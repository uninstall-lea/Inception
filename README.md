<p align="center">
  <img src="https://img.shields.io/badge/100_%2F_100-004d40?label=Final%20Grade&labelColor=151515&logo=data:image/svg%2bxml;base64,..." />&nbsp;
  <img src="https://img.shields.io/badge/Shell%20%2F%20Docker-2496ED?logo=docker&logoColor=white&label=Main%20Tech&labelColor=151515" />&nbsp;
  <img src="https://img.shields.io/badge/VM%20Setup-004d40?logo=linux&label=Environment&labelColor=151515" />
</p>

# 🕵️‍♀️ Inception

## 📖 Overview

**Inception** is a project from **42 Paris** designed to deepen system administration skills through the use of **Docker**, by virtualizing several services (**Nginx, WordPress, MariaDB**) inside a personal virtual machine.  
The setup follows a **LEMP stack** (Linux, Nginx, MariaDB, PHP/WordPress), built step by step with **Dockerfiles** and **docker-compose**, to understand containerization in practice.  

This project provided hands-on experience with **Dockerfiles, docker-compose, docker networks, SSL certificates, relational databases, and service management.**
See subject [here](https://github.com/uninstall-lea/Inception/blob/main/Inception.pdf).

## 🛠️ Installation & Setup

To get started, follow these steps to set up and run the project:

1. **Clone the repository**:

    >⚠️ Make sure to never commit your `.env` file as it contains sensitive credentials.

    Copy the .env template in [note.txt](https://github.com/uninstall-lea/Inception/blob/main/note.txt), fill it and save it as srcs/.env.
    ```bash
    git clone https://github.com/uninstall-lea/inception.git
    cd inception
    ```

2. **Build and start the containers**:
     ```bash
     make
     ```

3. **Access WordPress**:

    https://localhost
    (or the domain you configured, e.g. https://login.42.fr)

5. **Stop the containers**:
    ```bash
    make stop
    ```

## Useful commands

-  **Docker-Compose commands**:
    ```bash
    docker-compose up -d --build                  # create and build all the containers and they still run in the background
    docker-compose ps                             # check the status for all the containers
    docker-compose logs -f --tail 5               # see the last 5 lines of the logs of your containers
    docker-compose stop                           # stop a stack of your docker compose
    docker-compose down                           # destroy all your resources
    docker-compose config                         # check the syntax of you docker-compose file
    ```

-  **🧹Reset / Cleanup (optional)**:

    >**⚠️ Warning**: These commands will remove all containers, images and volumes on your system, not just those related to this project.

    If you need to completely clean your Docker environment, you can use:
    ```bash
    sudo docker stop $(docker ps -q)              # stop all containers
    sudo docker rm $(docker ps -aq)               # remove all containers
    sudo docker rmi -f $(docker images -q)        # remove all images
    sudo docker volume rm $(docker volume ls -q)  # remove all volumes
    sudo docker system prune -af                  # prune everything
    ```

## 🔍 Technologies Used

- **Docker & docker-compose** – Build and manage multi-container environments.  
- **Nginx** – Web server configured with SSL (HTTPS).  
- **WordPress** – Content management system running inside containers.  
- **MariaDB** – Relational database for persisting WordPress data.  
- **Docker network** – Secure communication between containers.  
- **Alpine / Debian** – Lightweight Linux distributions used as container base images.  
	
Thank you for checking out Inception! 🌟