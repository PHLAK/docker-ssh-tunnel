FROM alpine:3.11
LABEL maintainer="Chris Kankiewicz <Chris@ChrisKankiewicz.com>"

ARG SSHD_VERSION=8.1_p1-r0

RUN install -d -g nobody -o nobody -m 700 /.ssh \
    && install -g nobody -o nobody -m 600 /dev/null /.ssh/authorized_keys \
    && passwd -u nobody

COPY files/authorize-key /usr/local/bin/authorize-key
RUN chmod +x /usr/local/bin/authorize-key

RUN apk add --update openssh-server=${SSHD_VERSION} tzdata \
    && rm -rf /var/cache/apk/*

EXPOSE 22

VOLUME /.ssh /etc/ssh

CMD ["/usr/sbin/sshd", "-D", "-e"]
