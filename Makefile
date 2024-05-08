NAME			= Inception
USER			= lbisson

SYSTEM_USER		= $(shell echo $$USER)
DOCKER_CONFIG	= $(shell echo $$HOME/.docker)

SRC_DIR			= ./srcs
VOL_DIR			= /home/$(USER)/data

WP_NAME			= wordpress
MDB_NAME		= mariadb
NGX_NAME		= nginx

all:			volumes hosts up
				@echo "\n"
				@echo "${GREEN}#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#${NC}"
				@echo "${GREEN}#\t\tWelcome to ${NAME} by ${USER}\t\t\t\t\t#${NC}"
				@echo "${GREEN}#\t\tWordpress is running at ${USER}.42.fr\t\t\t\t#${NC}"
				@echo "${GREEN}#\t\tTo access wordpress admin, go to ${USER}.42.fr/wp-admin\t\t#${NC}"
				@echo "${GREEN}#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#${NC}"
				@echo "\n"

volumes:
				@echo "${YELLOW}~~~~~~~~~~~ [Creating Docker Volumes] ~~~~~~~~~~~~${NC}"
				sudo mkdir -p ${VOL_DIR}/${WP_NAME}
				sudo docker volume create --driver local --opt type=none --opt device=${VOL_DIR}/${WP_NAME} --opt o=bind ${WP_NAME}
				sudo mkdir -p ${VOL_DIR}/${MDB_NAME}
				sudo docker volume create --driver local --opt type=none --opt device=${VOL_DIR}/${MDB_NAME} --opt o=bind ${MDB_NAME}
				sudo mkdir -p ${VOL_DIR}/${NGX_NAME}
				sudo docker volume create --driver local --opt type=none --opt device=${VOL_DIR}/${NGX_NAME} --opt o=bind ${NGX_NAME}
				@echo "${GREEN}~~~~~~~~~~~~~~~ [Volumes Created] ~~~~~~~~~~~~~~~${NC}"

hosts:
				@echo "${YELLOW}~~~~~ [Editing hosts file with domain name] ~~~~~${NC}"
				@if ! grep -qFx "127.0.0.1 ${USER}.42.fr" /etc/hosts; then \
					sudo sed -i '2i\127.0.0.1\t${USER}.42.fr' /etc/hosts; \
				fi
				@echo "${GREEN}~~~~~~~~~~~~~~ [Hosts file edited] ~~~~~~~~~~~~~~${NC}"

up:
				@echo "${YELLOW}~~~~~~~~~~~~~~~ [Starting Docker] ~~~~~~~~~~~~~~~${NC}"
				sudo docker compose -f ${SRC_DIR}/docker-compose.yml up -d --build
				@echo "${GREEN}~~~~~~~~~~~~~~~~ [Docker Started] ~~~~~~~~~~~~~~~~${NC}"

down:
				@echo "${YELLOW}~~~~~~~~~~~~~~~ [Stopping Docker] ~~~~~~~~~~~~~~~${NC}"
				@docker compose -f ${SRC_DIR}/docker-compose.yml down
				@echo "${GREEN}~~~~~~~~~~~~~~~~ [Docker Stopped] ~~~~~~~~~~~~~~~${NC}"

clean:			down
				@echo "${YELLOW}~~~~~~~~~~~ [Removing Docker Volumes] ~~~~~~~~~~~~${NC}"
				docker volume rm ${WP_NAME}
				docker volume rm ${MDB_NAME}
				docker volume rm ${NGX_NAME}
				sudo rm -rf /home/$(USER)/data/${NGX_NAME}
				@echo "${RED}~~~~~~~~~~~~~~~ [Volumes Removed] ~~~~~~~~~~~~~~~~${NC}"

fclean:			clean
				@echo "${YELLOW}~~~~~~~~~~~~ [Removing Docker Files] ~~~~~~~~~~~~~${NC}"
				sudo rm -rf /home/$(USER)/data/${WP_NAME}
				sudo rm -rf /home/$(USER)/data/${MDB_NAME}
				sudo rm -rf /home/$(USER)/data/${NGX_NAME}
				@echo "${RED}~~~~~~~~~~~~~~~~ [Files Removed] ~~~~~~~~~~~~~~~~~${NC}"
				@echo "${YELLOW}~~~~~ [Removing domain name from hosts file] ~~~~~${NC}"
				sudo sed -i '/127\.0\.0\.1\t${USER}\.42\.fr/d' /etc/hosts
				@echo "${RED}~~~~~~~~~~~~~~~ [Hosts file edited] ~~~~~~~~~~~~~~${NC}"

re:				fclean all

PHONY:			all clean re prepare

# Colors
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[0;33m
NC = \033[0m

# Always start docker at reboot (only in unbuntu (do it the 1st time in you VM), for wsl see /etc/wsl.conf)
#	sudo systemctl enable docker

# Start docker services (if not enable previously)
#	$ sudo service docker start

# Check if docker is running
#	$ sudo service docker status

# Listen running containers
#	$ docker ps -a

# Build container
# 	$ docker build -t [name] [directory]

# Run container
#	$ docker run -it [name]

# Stop all containers 
#	$ docker stop $(docker ps -a -q)

# Remove all containers
#	$ docker rm $(docker ps -a -q)

# Change lea by lbisson when testing at school