# Export environment from .env

include srcs/.env
export

# Variables

NAME	= inception
DOCO	= docker-compose -f srcs/docker-compose.yml -p ${NAME}

# General rules

all :
	${DOCO} up -d --build

stop :
	$(DOCO) stop

clean:
	${DOCO} down -v
	if [ -n "(${DOCO} images -q)" ]; then \
		docker image rm $$(${DOCO} image -q); \
	fi

fclean : clean
	sudo rm -rf /home/&&USER/data/mariadb-data /home/$$USER/data/wordpress-data /home/$$USER/data/ss1

re: fclean all

# PHONY

.PHONY: all stop clean fclean re
