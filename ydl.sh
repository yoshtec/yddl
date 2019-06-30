#!/bin/bash
DATE=$(date)
echo "${DATE}: INVOKE: $0" >> /data/yddl.log

cd /data
youtube-dl --no-cache-dir --no-call-home --no-color "$1" >> /data/yddl.log
