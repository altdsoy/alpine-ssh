#!/bin/sh
set -e

echo -e "$SSH_PRIVATE_KEY" > ~/ssh_key

exec "$@"
