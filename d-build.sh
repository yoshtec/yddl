#!/usr/bin/env bash

docker image rm yddl:latest --force
docker build -t yddl:latest .
