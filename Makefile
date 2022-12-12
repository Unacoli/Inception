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
	mkdir -p "./srcs/images/nginx/ssl/"
	if [ ! -f "./srcs/images/nginx/ssl/cert.pem" ] || [ ! -f "./srcs/images/nginx/ssl/key.pem" ]; then \
	openssl req -newkey rsa:4096 -nodes -keyout "./srcs/images/nginx/ssl/key.pem" -x509 -days 365 -out "./srcs/images/nginx/ssl/cert.pem" -subj "/CN=$$DOMAIN_NAME" -addext "subjectAltName=DNS:$$DOMAIN_NAME,DNS:$$DOMAIN_NAME"; \
	fi

stop:
	$(DOCO) stop

clean:
	${DOCO} down

fclean : clean
	${DOCO} down -v

rm-data:
	sudo rm -rf "/home/$$USER/data/"
	rm -rf "./srcs/images/nginx/ssl/"

re: fclean all

# Docker rules

build:
	${DOCO} build

upd: data
	${DOCO} up -d

# PHONY

.PHONY: all data ssl stop clean fclean rm-data re build upd
