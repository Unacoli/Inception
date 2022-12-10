# Export environment from .env

include srcs/.env
export

# Variables

NAME	= inception
DOCO	= docker-compose -f srcs/docker-compose.yml -p ${NAME}

# General rules

all: data build upd

data: ssl
	mkdir -p "/home/$$USER/data/"
	mkdir -p "/home/$$USER/data/mariadb_data/"
	mkdir -p "/home/$$USER/data/wp_data/"

ssl:
	mkdir -p "/srcs/images/nginx/ssl/"
	openssl req -newkey rsa:4096 -nodes -keyout "/srcs/images/nginx/ssl/key.pem" -x509 -days 365 -out "/srcs/images/nginx/ssl/cert.pem"

stop:
	$(DOCO) stop

clean:
	${DOCO} down

fclean : clean
	${DOCO} down -v

re: fclean all

# Docker rules

build:
	${DOCO} build

upd:
	${DOCO} up -d

# PHONY

.PHONY: all data ssl stop clean fclean re build upd
