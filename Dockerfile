FROM ubuntu:16.04
LABEL maintainer="Carles San Agustin"
LABEL maintainer="twitter.carlessanagustin.com"

EXPOSE 80 443

ENV NAGIOSPASSWORD=nagios123
ENV DEBIAN_FRONTEND=noninteractive

RUN cd $HOME && \
    apt-get update && \
    apt-get install -y ssmtp mailutils && \
    apt-get install -y apt-utils && \
    echo "nagios3-cgi nagios3/adminpassword string $NAGIOSPASSWORD" | debconf-set-selections && \
    echo "nagios3-cgi nagios3/adminpassword-repeat string $NAGIOSPASSWORD" | debconf-set-selections && \
    apt-get install -y nagios3 nagios-plugins nagios-nrpe-plugin && \
    apt-get install -y nagios-nrpe-server nagios-plugins

COPY wrapper_script.sh wrapper_script.sh
CMD ["./wrapper_script.sh"]
