# Inception

This project aims to broaden your knowledge of system administration by using Docker.
You will virtualize several Docker images, creating them in your new personal virtual
machine.

This project has been validated with a score of 100/100.

# Usage

This project is set up to work on a Fedora 37 VM.

- Run `make vm-config`
- Run `make`
- Open https://nargouse.42.fr

# Makefile commands

- `make data` to create directory for data and SSL certificates
- `make ssl` to create SSL certificates
- `make stop` to stop containers
- `make clean` to down containers
- `make fclean` to down containers and delete volumes
- `make rm-data` to delete containers data
- `make build` to build images
- `make upd` to up detached containers
