#!/bin/bash
echo "INFO: Starting yddl docker"

if [ -n "$YDDL_PASSWORD" ]; then
  echo "yddl:$YDDL_PASSWORD" | chpasswd
  echo "INFO: password set"
  unset YDDL_PASSWORD
else
  echo "WARNING: No password has been set for the the user yddl" >&2
fi

if [ "$1" = 'yddl' ]; then
  echo "INFO: Starting deamon"
  /usr/sbin/sshd -D
fi

/usr/sbin/sshd -D

echo "INFO: exited"
