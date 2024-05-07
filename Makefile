HOME			=	/home/lea

DOCKER_COMPOSE	=	sudo docker compose

all:	build
		$(DOCKER_COMPOSE) -f srcs/docker-compose.yml up --detach

log:	build
		$(DOCKER_COMPOSE) -f srcs/docker-compose.yml up

folders:
		mkdir -p $(HOME)/data/mariadb_volume
		mkdir -p $(HOME)/data/wordpress_volume

build:	folders
		$(DOCKER_COMPOSE) -f srcs/docker-compose.yml build

stop:
		$(DOCKER_COMPOSE) -f srcs/docker-compose.yml stop

clean:	stop
		sudo docker system prune -f -a

fclean:	clean
		docker volume ls -q | xargs -r docker volume rm -f
		sudo rm -rf $(HOME)/data

re: 	fclean all

.PHONY: folders all stop clean fclean re

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

# Change lea by lea when testing at school