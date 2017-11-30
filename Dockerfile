FROM jcgruenhage/baseimage-alpine
MAINTAINER Jan Christian Grünhage <jan.christian@gruenhage.xyz>

ENV	UID=192 \
	GID=192 \
	STAGING=1 \
	CHALLENGE="dns-01"

# Set STAGING to false(0) by default, set to true(1) to use staging LE-Endpoint
# Set CHALLENGE to "dns-01" (DNS Challenge) by default, set to "http-01" to use the HTTP Challenge

RUN apk update \
	&& apk add --upgrade \
		git \
		openssl \
		curl \
		sed \
		grep \
		bash \
		su-exec \
		libxml2-utils \
	&& git clone https://github.com/lukas2511/dehydrated /dehydrated

# Add the files in the 'root' folder to the images filesystem
ADD root /

VOLUME /etc/dehydrated
VOLUME /var/www/dehydrated
VOLUME /certs

# Execute the setup script
RUN bash /etc/once/setup.sh
