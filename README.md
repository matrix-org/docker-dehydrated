# docker-dehydrated

[![Stars](https://img.shields.io/docker/stars/matrixdotorg/dehydrated.svg)](https://hub.docker.com/r/matrixdotorg/dehydrated/) [![Pulls](https://img.shields.io/docker/pulls/matrixdotorg/dehydrated.svg)](https://hub.docker.com/r/matrixdotorg/dehydrated/) [![Automated](https://img.shields.io/docker/automated/matrixdotorg/dehydrated.svg)](https://hub.docker.com/r/matrixdotorg/dehydrated/) [![Build Status](https://img.shields.io/docker/build/matrixdotorg/dehydrated.svg)](https://hub.docker.com/r/matrixdotorg/dehydrated/)

We use this internally for automating our certificate management using [dehydrated](https://github.com/lukas2511/dehydrated). We do not support this further than needed for our usage, but feel free to use it if you want.

## Usage
We have short tutorials for two different modi operandi: The `dns-01` and `http-01` challenge.
Both are fairly easy to use. The `dns-01` challenge requires less effort if your DNS provider
is supported by [lexicon](https://github.com/AnalogJ/lexicon/#providers), the `http-01` challenge otherwise.

For a short tutorial of getting a certificate with this container and the `dns-01` challenge,
go [here](dns-01.md), for the same using the `http-01` challenge, go [here](http-01.md).

## Behaviour
By default the container will attempt to generate a config as `/data/config`
with the default values for all the environment variables.
The defaults are explicitly meant to not work. Things you need to change:
 - set `DEHYDRATED_ACCEPT_TERMS` to yes, ***after reading letsencrypts ToS***
 - set `DEHYDRATED_EMAIL` to an email address you own
 - set `DEHYDRATED_CA` to a production ACME CA, for example letsencrypt's ACME v2 endpoint, "https://acme-v02.api.letsencrypt.org/directory"
   - Only do this ***after*** you have tried it with the default staging endpoint
   and it worked and you got the certificates you want. If this fails too often,
   letsencrypt will block your IP and domain for a week, so do your experiments
   on the staging endpoint.

### Advanced configuration
- `DEHYDRATED_CA`:
This controls which ACME endpoint dehydrated contacts. The most common value for
production environments is "https://acme-v02.api.letsencrypt.org/directory",
while you should use "https://acme-staging-v02.api.letsencrypt.org/directory"
for experiments.
- `DEHYDRATED_CHALLENGE`:
You can either put `dns-01` or `http-01` here, depending on how you want letsencrypt
to verify that you are allowed to obtain this certificate.
- `DEHYDRATED_KEYSIZE`:
This defaults to `4096`, but you could also put `2048` or `3072` here, if you want
less secure but slightly faster keys. This only makes sense if your host or your clients
are *very slow*.
- `DEHYDRATED_KEY_ALGO`:
This defaults to `rsa` but you could also put `prime256v1` or `secp384r1` here.
`DEHYDRATED_KEYSIZE` is only relevant for `rsa` certs, but still controls the acocunt key size.
- `DEHYDRATED_HOOK`:
If you use the `dns-01` challenge, you need to supply a hook script,
which dehydrated will use to set dns records. The container ships with
lexicon installed and a lexicon hook in `/usr/local/bin/lexicon-hook`.
Apart from the `dns-01` challenge, you can also use hooks to deploy newly created
certificates. For more info see [dehydrated's project page](https://github.com/lukas2511/dehydrated).
- `DEHYDRATED_RENEW_DAYS`:
When dehydrated runs, it will check if any certificates need renewal and renew those.
All certificates which expire in the next `n` days will be renewed, where `n` is the
number you set here. Default is 30
- `DEHYDRATED_KEY_RENEW`:
Set this to yes to make dehydrated renew keys too when renewing certificates, or to
no to keep the keys.
- `DEHYDRATED_ACCEPT_TERMS`:
For the first run this needs to be set to yes, else dehydrated will not work.
Read the terms of service of letsencrypt before setting this to yes.
- `DEHYDRATED_EMAIL`:
Set your email address here.
- `DEHYDRATED_GENERATE_CONFIG`:
Set to yes by default. If you want to use a config supplied by you,
change this to no and put your own config in `/data/config`
- `UID` and `GID`: You can set the UID and GID of the things run in the docker container here.s
