FROM python:3-alpine

LABEL description="This image is a ssh separate ssh installation and youtube-dl python skript intended to be used with Apple iOS Shortcuts"
LABEL usage="docker run --name:yddl -v /path/to/downloads:/data -d  -p 10022:22 -e YDDL_PASSWORD=some_password -P yddl:latest yddl"


## Install server requirements
RUN apk update && apk upgrade
RUN apk add --no-cache openssh-server ffmpeg bash
# install youtube-dl
RUN pip install --no-cache-dir youtube-dl


# Setup user
RUN addgroup -S yddl && adduser -S yddl -G yddl --shell /bin/bash
RUN echo "yddl:yddl" | chpasswd

## config ssh server - to allow login 
RUN ssh-keygen -A
RUN echo "ChallengeResponseAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "PermitRootLogin no" >> /etc/ssh/sshd_config
RUN echo "PrintMotd no" >> /etc/ssh/sshd_config
#RUN echo "PrintMotd no" >> /etc/ssh/sshd_config
RUN echo "AllowTCPForwarding no" >> /etc/ssh/sshd_config
RUN echo "AllowUsers yddl" >> /etc/ssh/sshd_config
RUN echo "Match User yddl" >> /etc/ssh/sshd_config
RUN echo "  ForceCommand /usr/local/bin/yddl" >> /etc/ssh/sshd_config


# copy importand files
COPY yddl-entrypoint.sh /usr/local/bin/
COPY ydl.sh /usr/local/bin/yddl

# espose ssh port
EXPOSE 22/tcp

# mount data where you want to put downloaded videos
VOLUME "/data"

ENTRYPOINT ["yddl-entrypoint.sh"]
