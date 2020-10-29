#!/bin/bash

docker build -t ft_server . 
docker run -itd -p 8000:80 -p 443:443 --name ft_server ft_server