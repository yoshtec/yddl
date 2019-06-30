#!/usr/bin/env bash

# example how to run the docker file

if [ -n "$1" ]; then

    # stop current running 
    docker stop yddl 
    docker rm yddl
    
    ##--restart unless-stopped
    docker run --name=yddl --user yddl -v $1:/data -d --publish=10022:22 -P yddl:latest yddl
else 
  echo "Please provide Data PATH as parameter"
fi