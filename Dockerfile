FROM alpine:latest

RUN apk add --no-cache \
    openssh-client \
    ca-certificates \
    bash

RUN mkdir -p ~/.ssh \
    && chmod 700 ~/.ssh \
    && echo -e "Host *\n\tStrictHostKeyChecking no\n\tIdentityFile ~/ssh_key\n\n" > ~/.ssh/config \
    && touch ~/ssh_key \
    && chmod 600 ~/ssh_key

COPY set_ssh_from_env.sh /usr/local/bin/

ENTRYPOINT ["set_ssh_from_env.sh"]

CMD ["/bin/sh"]
