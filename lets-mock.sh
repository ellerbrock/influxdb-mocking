#!/usr/bin/env bash

#
# InfluxDB Settings
#
INFLUXDB_HOST="frapcloud"
INFLUXDB_PORT=8086
INFLUXDB_PROTOCOL="http"
INFLUXDB_DB="onsite"
INFLUXDB_KEY="Fast.Controller_1.Value_0001"
INFLUXDB_WRITE="${INFLUXDB_PROTOCOL}://${INFLUXDB_HOST}:${INFLUXDB_PORT}/write?db=${INFLUXDB_DB}"


#
# Script Settings
#
DEBUG=true
TIMER=0.5
VAL_TYPE="RND"   # RND (random value) or CNT (counter)
RANDOM_MAX=1000  # max possible random value
COUNTER=0        # start value for counter


#
# create influx database
#
curl -XPOST ${INFLUXDB_PROTOCOL}://${INFLUXDB_HOST}:${INFLUXDB_PORT}/query \
      --data-urlencode "q=CREATE DATABASE ${INFLUXDB_DB}"

#
# fire the query to the api
#
while true # go drink a beer :)
do
  ${DEBUG} && echo "value: ${VAL:-0} | timestamp: $(date +%s)"

  if [[ ${VAL_TYPE} -eq "RND" ]]; then
    VAL=$(( $RANDOM % ${RANDOM_MAX} ))
  else
    VAL=COUNTER++
  fi

  curl -XPOST ${INFLUXDB_WRITE} \
       --data-binary "${INFLUXDB_KEY} value=${VAL} $(date +%s)" \
       --user-agent "Mozilla/2.0 (compatible; MSIE 3.0; Windows 3.1)" # :-)

  sleep ${TIMER}
done

