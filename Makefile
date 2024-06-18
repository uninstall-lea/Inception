SOURCES_FOLDER	:=	./srcs/
COMPOSE			:=	docker compose --project-directory ${SOURCES_FOLDER}
DATA			:=	${HOME}/data
VOLUMES			:=	${addprefix ${DATA}/,	\
						wordpress			\
						mariadb				\
					}

all: up

up: create_dir build create
	${COMPOSE} up -d

stop down build create:
	${COMPOSE} $@

create_dir:
	mkdir -p ${VOLUMES}

clean:
	${COMPOSE} down --rmi all

fclean:
	${COMPOSE} down --rmi all --volumes
	docker system prune -af
	sudo rm -rf ${VOLUMES}

re: fclean all

.PHONY: all up create_dir re clean fclean stop down build create