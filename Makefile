HOME			=	/home/lbisson

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