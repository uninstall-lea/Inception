all			:	build

build		:
				sudo mkdir -p /Users/lbisson/data/mariadb
				sudo mkdir -p /Users/lbisson/data/wordpress
				docker-compose -f srcs/docker-compose.yml build

up			:
				sudo mkdir -p /Users/lbisson/data/mariadb
				sudo mkdir -p /Users/lbisson/data/wordpress
				docker-compose -f srcs/docker-compose.yml up --detach

stop		:
				docker-compose -f srcs/docker-compose.yml -d stop

purge		:
				docker system prune -af
				sudo rm -rf /Users/lbisson/data/mariadb
				sudo rm -rf /Users/lbisson/data/wordpress

re 			:
				make purge
				sudo mkdir -p /Users/lbisson/data/mariadb
				sudo mkdir -p /Users/lbisson/data/wordpress
				make build
				make up

clean		:
				docker-compose -f srcs/docker-compose.yml down -v