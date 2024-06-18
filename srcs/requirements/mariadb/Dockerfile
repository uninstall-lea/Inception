FROM debian:bullseye

RUN	apt update -y && \
	apt upgrade -y && \
	apt install -y  mariadb-client mariadb-server gettext

COPY conf/my.cnf /etc/mysql/my.cnf
COPY tools/init-db.sql /scripts/init-db.sql
COPY tools/launch.sh /scripts/launch.sh

RUN chmod -R 755 /scripts

EXPOSE 3306

ENTRYPOINT ["/scripts/launch.sh"]