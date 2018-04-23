FROM docker.jcg.re/base-alpine

RUN apk add --no-cache \
      --virtual .build-deps \
      git \
      python3-dev \
      libffi-dev \
      build-base \
      openssl-dev \
 && apk add --no-cache \
      --virtual .runtime-deps \
      openssl \
      curl \
      sed \
      grep \
      bash \
      su-exec \
      libxml2-utils \
 && git clone https://github.com/lukas2511/dehydrated /dehydrated \
 && pip3 install requests[security] \
 && pip3 install dns-lexicon \
 && apk del .build-deps

ADD root /

VOLUME /etc/dehydrated
VOLUME /var/www/dehydrated
VOLUME /certs

