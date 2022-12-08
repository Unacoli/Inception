# Export environment from .env

include srcs/.env
export

# Variables

NAME	= inception
DOCO	= docker-compose -f srcs/docker-compose.yml -p ${NAME}

# General rules

all: build upd

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

.PHONY: all run ssl stop clean fclean re build upd
