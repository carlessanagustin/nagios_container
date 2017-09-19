# docker run -it -p 80:80 -p 443:443 -v $(pwd):/shared ubuntu:16.04 bash

FROM ubuntu:16.04

ENV MAILNAME=your.hostname.com
ENV NAGIOSPASSWORD=nagios123

RUN cd $HOME && \
    apt-get update && \
    echo "postfix postfix/mailname string $MAILNAME" | debconf-set-selections && \
    echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y nagios3 && \
    apt-get install -y nagios-plugins nagios-nrpe-plugin && \
    apt-get install -y nagios-nrpe-server nagios-plugins && \
    htpasswd -cb /etc/nagios3/htpasswd.users nagiosadmin $NAGIOSPASSWORD

RUN apt-get install -y supervisor
