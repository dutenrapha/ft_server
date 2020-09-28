FROM debian:buster

COPY srcs /tmp/

RUN apt update && \
    apt upgrade -y && \
    apt install nginx -y && \
	apt install mariadb-server -y && \
	apt install php-fpm php-mysql -y

RUN bash /tmp/init.sh

EXPOSE 80

ENTRYPOINT bash /tmp/run.sh