# Zero-configuration mode

This is a tutorial on how to use this container (without needing to configure anything) to create
certificates for a given set of domains (using the HTTP-Challenge).

## Prerequisites

These are the things that you need to setup / already have set up in order to use this container
for creating certificates using the HTTP-Challenge:

- A working internet connection, obviously
- HTTP Webserver to serve the ``.well-known`` which is used for the HTTP-Challenge

Now create a folder in which dehydrated can push the challenge-data later, in this tutorial it
will be called ``dehydrated-www``. Configure your Webserver to serve the contents of this folder
under ``domain``/.well-known/ (for all domains for which you want to create certificates).

Next create another folder in which dehydrated will place its configuration, certificates etc.,
in this tutorial it will be called ``dehydrated-data``. In this folder, create a file called
``domains.txt`` in which you list the domains you want to create certificates for, using the
following format:

- each domain on a new line
- subdomains of a domain on the same line as the domain.

For more information on the format, see [https://github.com/lukas2511/dehydrated/blob/master/docs/domains_txt.md](https://github.com/lukas2511/dehydrated/blob/master/docs/domains_txt.md)

## Using docker-dehydrated

Now you can just run the container, and as the default challenge is the HTTP-Challenge, you do
not need to pass environment variables to alter the default behaviour. To run the container,
execute:

```bash
$ docker run -v ./dehydrated-www:/var/www/dehydrated \
-v ./dehydrated-data:/etc/dehydrated docker.jcg.re/dehydrated
```

Please note that on SELinux-Systems, you need to set the "SELinux"-Flag when passing volumes:
``./dehydrated-www:/var/www/dehydrated:z`` (analog for ``dehydrated-data``).

Also, the container will ``chown`` the folders passed to himself, so make sure your webserver can
still serve the contents of ``dehydrated-www``.

After the challenges have been run, the certificates will be stored in ``dehydrated-data/certs``,
make sure to back this folder up!
