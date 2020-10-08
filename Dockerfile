FROM alpine:latest

RUN apk add --no-cache \
    openssh-client \
    ca-certificates \
    bash

COPY set_ssh_config.sh /usr/local/bin/

ENTRYPOINT ["set_ssh_config.sh"]

CMD ["/bin/sh"]
