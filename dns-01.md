## Prerequisites

For using the container with the  `dns-01`-challenge, you need on your machine:

- docker-compose (and docker obviously)

Download [the docker-compose example](https://git.jcg.re/jcgruenhage/docker-dehydrated/raw/branch/master/examples/docker-compose.dns-01.yml)
as `docker-compose.yml` into an empty folder. Inside that folder, create the folder `data`.

Now, create a file `data/domains.txt` in which you list the domains you want to create certificates for,
using the following format:

- each certificate on a new line
- each line can contain a list of (sub)domains, separated by spaces

For more information on the format, see [the dehydrated documentation](https://github.com/lukas2511/dehydrated/blob/master/docs/domains_txt.md).

Before running, you need to set a few things in the `docker-compose.yml` file,
as explained [here in the README](https://git.jcg.re/jcgruenhage/docker-dehydrated#behaviour)

## Configuring DNS API access

Dehydrated needs to be able to add and remove DNS entries. For this,
the `docker-compose.yml` file contains an example how this works with Cloudflare.
Set your email and token there, and if you use another provider from
[this list](https://github.com/AnalogJ/lexicon/#providers), do the same but replace
cloudflare with your provider everywhere.

## Using docker-dehydrated

Inside the folder where you put the `docker-compose.yml` file, run this command:

```bash
docker-compose up
```

This will create the requested certificates, if possible.
It will also check once per week whether the certificates need to be renewed,
and do so if necessary. To start the container in the background, add ` -d`
to the end of the command above.

Please note that the container will `chown` the folders passed to it, so make sure your webserver can
still serve the contents of `data/wellknown`. You can configure the UID and GID
that the container uses by adding a UID and GID environment variable to the
`docker-compose.yml` file.

After the challenges have been run, the certificates will be stored in `data/certs`.
