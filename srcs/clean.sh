#!/bin/bash

#sudo docker-compose down --rmi all --volumes
sudo docker stop $(sudo docker ps -q)
sudo docker rm -f $(sudo docker ps -aq)
sudo docker system prune -af
sudo docker volume rm $(sudo docker volume ls -q)