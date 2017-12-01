#docker-dehydrated

This is a docker container that wraps around [dehydrated](https://github.com/lukas2511/dehydrated).

## Environment variables

The following environment variables can be set to influence the container's behaviour:

- $ENDPOINT which ACME-Endpoint you want to use, supported values: "staging", "production" (default).
- $CHALLENGE what type of challenge should be used, supported values: "http-01" (default), "dns-01"
