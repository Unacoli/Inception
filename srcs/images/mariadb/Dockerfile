FROM debian:buster

LABEL maintainer="nargouse@student.42.fr"

# install mariadb on the container
RUN apt-get update
RUN apt-get install -y mariadb-server mariadb-client vim && rm -rf /var/lib/apt/lists/*

# create directory for database and configure database for mariadb
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 777 /var/run/mysqld

# copy docker-entrypoint to the container
COPY ./docker-entrypoint.sh /usr/local/bin/
COPY ./conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf 
COPY ./tools/docker-healthcheck /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh && chmod +x /usr/local/bin/docker-healthcheck

EXPOSE 3306

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]

CMD [ "mysqld", "--bind-address=0.0.0.0" ]

# HEALTHCHECK CMD [ "/usr/local/bin/docker-healthcheck" ]