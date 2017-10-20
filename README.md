# Nagios in a Docker container

Includes:

* Nagios
* SSMTP
* Apache2
* NRPE

Requirements: Docker Engine

## Build

`docker build -t nagios:3 .`

## Run

`docker run -d -p 80:80 nagios:3`

## Run (local configuration)

Edit `configuration/*` files as desired
```
docker run -d -p 80:80 \
    -v $(pwd)/configuration/nagios3/commands.cfg:/etc/nagios3/commands.cfg \
    -v $(pwd)/configuration/nagios3/conf.d/:/etc/nagios3/conf.d/ \
    -v $(pwd)/configuration/nrpe/:/etc/nagios/ \
    -v $(pwd)/configuration/ssmtp/:/etc/ssmtp/ \
    nagios:3
```

## Use

* Visit: http://localhost/nagios3
  * Username: nagiosadmin
  * Password: nagios123
