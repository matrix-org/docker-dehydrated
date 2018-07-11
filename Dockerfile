FROM docker.io/alpine:3.8
LABEL maintainer="Jan Christian Grünhage <jcgruenhage@matrix.org>"

ENV UID=1337 \
    GID=1337

RUN apk add --no-cache \
      --virtual .build-deps \
      git \
      python3-dev \
      libffi-dev \
      build-base \
      openssl-dev \
      py2-pip \
 && apk add --no-cache \
      --virtual .runtime-deps \
      openssl \
      curl \
      sed \
      grep \
      bash \
      s6 \
      su-exec \
      libxml2-utils \
      py2-pip \
      python3 \
 && mkdir /opt \
 && git clone https://github.com/lukas2511/dehydrated.git /opt/dehydrated \
 && pip3 install requests[security] \
 && pip3 install dns-lexicon \
 && pip2 install j2cli[yaml] \
 && apk del .build-deps

ENV \
    DEHYDRATED_CA="https://acme-staging-v02.api.letsencrypt.org/directory" \
    DEHYDRATED_CHALLENGE="http-01" \
    DEHYDRATED_KEYSIZE="4096" \
    DEHYDRATED_HOOK="" \
    DEHYDRATED_RENEW_DAYS="30" \
    DEHYDRATED_KEY_RENEW="yes" \
    DEHYDRATED_ACCEPT_TERMS="no" \
    DEHYDRATED_EMAIL="user@example.org" \
    DEHYDRATED_GENERATE_CONFIG="yes"

ADD root /

VOLUME /data

CMD ["/bin/s6-svscan", "/etc/s6.d"]
