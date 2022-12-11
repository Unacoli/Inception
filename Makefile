# Export environment from .env

include srcs/.env
export

# Variables

NAME	= inception
DOCO	= docker-compose -f srcs/docker-compose.yml -p ${NAME}

# General rules

all: data build upd

data: ssl
	mkdir -p "~/data/"
	mkdir -p "~/data/mariadb_data/"
	mkdir -p "~/data/wp_data/"

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

re: fclean all

# Docker rules

build:
	${DOCO} build

upd:
	${DOCO} up -d

# PHONY

.PHONY: all data ssl stop clean fclean re build upd
