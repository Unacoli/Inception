# Export environment from .env

include srcs/.env
export

# Variables

NAME	= inception
DOCO	= docker-compose -f srcs/docker-compose.yml -p ${NAME}

# General rules

all: data build upd

vm-config:
	sudo dnf install openssl
	sudo dnf -y install dnf-plugins-core
	sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
	sudo dnf install docker-ce docker-ce-cli containerd.io docker-compose-plugin
	sudo systemctl start docker
	sudo docker run hello-world
	sudo dnf install docker-compose
	sudo chmod 777 /etc/hosts/
	echo -e "127.0.0.1\tnargouse.42.fr" >> /etc/hosts

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
	${DOCO} build --add-host

upd: data
	${DOCO} up -d

# PHONY

.PHONY: all vm-config data ssl stop clean fclean rm-data re build upd
