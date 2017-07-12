FROM jcgruenhage/baseimage-alpine
MAINTAINER Jan Christian Grünhage <jan.christian@gruenhage.xyz>

ENV	UID=192 \
	GID=192

RUN apk update \
	&& apk add --upgrade \
		git \
		openssl \
		curl \
		sed \
		grep \
		bash \
		su-exec \
	&& git clone https://github.com/lukas2511/dehydrated /dehydrated 

ADD root /


VOLUME /etc/dehydrated
VOLUME /var/www/dehydrated
VOLUME /certs

