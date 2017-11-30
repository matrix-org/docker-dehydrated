#!/bin/bash

# Copy the example config file to the config location
cp /dehydrated/docs/examples/config /etc/dehydrated/config

# Use the staging endpoint?
if [ $STAGING -ne 0 ]; then
	sed -ie 's/#CA=.*$/CA="https:\/\/acme-staging.api.letsencrypt.org\/directory"/g' /etc/dehydrated/config
	sed -ie 's/#CA_TERMS=.*$/CA_TERMS="https:\/\/acme-staging.api.letsencrypt.org\/terms"/g' /etc/dehydrated/config
fi

# Set the challenge-type
case "$CHALLENGE" in
	"http-01")
		sed -ie 's/#CHALLENGETYPE=.*$/CHALLENGETYPE="http-01"/g' /etc/dehydrated/config
	;;
	"dns-01")
		sed -ie 's/#CHALLENGETYPE=.*$/CHALLENGETYPE="dns-01"/g' /etc/dehydrated/config
	;;
	*)
		echo "WARNING: Unknown Challenge type! Using default from dehydrated"
	;;
esac
