#!/bin/bash

docker build -t ft_server . 
docker run -itd -p 8000:80 --name ft_server ft_server