#!/bin/sh
set -e

mkdir -p ~/.ssh
chmod 700 ~/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n\tIdentityFile ~/ssh_key\n\n" > ~/.ssh/config
echo -e "$SSH_PRIVATE_KEY" > ~/ssh_key
chmod 600 ~/ssh_key

exec "$@"
