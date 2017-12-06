# docker-dehydrated

This is a docker container that wraps around [dehydrated](https://github.com/lukas2511/dehydrated).

## Usage

For a short tutorial on how to use this container with zero-configuration to sign certificates
using the HTTP-Challenge, see [zero-config-mode.md]("Zero-Config"-Mode).

## Environment variables

The following environment variables can be set to influence the container's behaviour:

- `$ENDPOINT` which ACME-Endpoint you want to use, supported values: "staging", "production" (default).
- `$CHALLENGE` what type of challenge should be used, supported values: "http-01" (default), "dns-01"

If the environment variables were not explicitely set, no modification to the configuration file is made

## Behaviour on startup

When the container is started, a script is run which looks for the configuration file in the places supported by dehydrated,
and if no configuration file is found, it will copy the [example configuration file](https://github.com/lukas2511/dehydrated/docs/examples/config)
into `/etc/dehydrated/config`.

