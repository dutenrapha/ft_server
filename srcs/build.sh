#!/bin/bash

sudo docker build -t ft_server . 
sudo docker run -itd -p 80:80 -p 443:443 --name ft_server ft_server
