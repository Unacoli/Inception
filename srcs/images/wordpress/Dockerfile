FROM debian:buster

LABEL maintainer="nargouse@student.42.fr"

RUN apt-get update
RUN apt-get -y install wget curl bash php php-cgi php-mysql php-fpm php-pdo php-gd php-cli php-mbstring && rm -rf /var/lib/apt/lists/*

# Install wp_cli who is used to install wp
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Put the conf in the html directory
COPY ./conf/www.conf /etc/php/7.3/fmpm/pool.d/

# Create the folder to enable php
RUN mkdir -p /run/php

COPY ./docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

WORKDIR /var/www/html/

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.3", "-F"]
