#!/bin/bash

sudo docker rm -f $(sudo docker ps -aq)
sudo docker rmi -f $(sudo docker images -q)
