FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt clean && apt upgrade -y

RUN apt install -y python3 python3-venv libaugeas0
RUN python3 -m venv /opt/certbot/ && /opt/certbot/bin/pip install --upgrade pip

RUN apt remove -y certbot

RUN /opt/certbot/bin/pip install certbot
RUN ln -s /opt/certbot/bin/certbot /usr/bin/certbot
RUN /opt/certbot/bin/pip install certbot-dns-dnsimple

RUN mkdir -p /usr/local/certbot

RUN echo "0 0,12 * * * /opt/certbot/bin/python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew -q" | tee -a /etc/crontab > /dev/null
RUN echo "@monthly /opt/certbot/bin/pip install --upgrade certbot certbot-dns-dnsimple" | tee -a /etc/crontab > /dev/null

CMD echo "dns_dnsimple_token = $DNSIMPLE_TOKEN" > /usr/local/certbot/dnsimple.ini; \
    certbot certonly \
        --dns-dnsimple \
        --dns-dnsimple-credentials /usr/local/certbot/dnsimple.ini \
        --dns-dnsimple-propagation-seconds 60 \
        -d $DOMAINS \
        -m $EMAIL \
        -n \
        --agree-tos; \
    /bin/bash