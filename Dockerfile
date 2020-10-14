FROM debian:buster

USER root

COPY srcs /tmp/

RUN apt update && \
	apt upgrade -y && \
	apt install nginx -y && \
	apt install mariadb-server -y && \
	apt install php-fpm -y && \
	apt install php-mysql -y

RUN bash /tmp/config.sh

EXPOSE 80

ENTRYPOINT bash /tmp/initalize.sh