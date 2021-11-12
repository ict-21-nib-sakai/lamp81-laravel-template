FROM php:8.1.0RC6-cli-alpine3.14

RUN apk update \
  && apk add --no-cache \
    supervisor \
  && rm -rf /var/cache/apk/*

COPY conf/etc/supervisord.empty.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]