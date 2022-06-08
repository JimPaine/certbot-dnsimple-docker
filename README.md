# certbot-dnsimple-docker

Docker image that contains certbot with the dnsimple plugin installed and cron jobs to update the plugin as well as handle renewals. On initial run it obtains a certificate.

## How to run

```sh
docker run \
    -dt \
    -e DNSIMPLE_TOKEN=$DNSIMPLE_TOKEN \
    -e DOMAINS=$DOMAINS \
    -e EMAIL=$EMAIL \
    certbot:beta
```

## (optional) Mount directories

Optionally mount directories for logs and certificates

```sh
docker run \
    -dt \
    -e DNSIMPLE_TOKEN=$DNSIMPLE_TOKEN \
    -e DOMAINS=$DOMAINS \
    -e EMAIL=$EMAIL \
    -v logs:/var/log \
    -v certs:/etc/letsencrypt/ \
    certbot:beta
```