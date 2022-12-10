FROM debian:buster

LABEL maintainer="nargouse@student.42.fr"

# install nginx and openssl on the container
RUN apt-get update
RUN apt-get install -y nginx openssl

# create directory for ssl certificates and copy local certificates
RUN mkdir -p /etc/nginx/ssl/mycerts
COPY ./ssl/cert.pem /etc/nginx/ssl/mycerts/cert.pem
COPY ./ssl/key.pem /etc/nginx/ssl/mycerts/key.pem

# copy nginx configuration on the container
COPY ./conf/nginx.conf /etc/nginx/conf.d

# nginx configuration
RUN mkdir -p /run/nginx

# expose the allowed port
EXPOSE 443

# start nginx
CMD ["nginx", "-g", "daemon off;"]