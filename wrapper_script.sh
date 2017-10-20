#!/bin/bash

# NAGIOS
/usr/sbin/nagios3 -d /etc/nagios3/nagios.cfg
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_second_process: $status"
  exit $status
fi

# APACHE
source /etc/apache2/envvars && /usr/sbin/apachectl -f /etc/apache2/apache2.conf
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_first_process: $status"
  exit $status
fi

# NRPE
/usr/sbin/nrpe -c /etc/nagios/nrpe.cfg -d
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_first_process: $status"
  exit $status
fi

# check
while /bin/true; do
  ps aux | grep nagios3 | grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux | grep apache2 | grep -q -v grep
  PROCESS_2_STATUS=$?
  ps aux | grep nrpe | grep -q -v grep
  PROCESS_3_STATUS=$?

  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 -o $PROCESS_3_STATUS -ne 0 ]; then
    echo "One of the processes has already exited: "
    echo "nagios3=$PROCESS_1_STATUS | apache2=$PROCESS_2_STATUS | nrpe=$PROCESS_3_STATUS"
    exit -1
  fi
  sleep 60
done
