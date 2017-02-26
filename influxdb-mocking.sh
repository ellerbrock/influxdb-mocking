#!/usr/bin/env bash

# Developer:  Maik Ellerbrock
# Date:       08.03.2917
# Version:    0.0.2


#
# InfluxDB Settings
#
INFLUXDB_HOST="YOUR-SERVER"
INFLUXDB_PORT=8086
INFLUXDB_PROTOCOL="http"
INFLUXDB_DB="YOUR-DATABASE"
INFLUXDB_KEY="YOUR-KEY"
INFLUXDB_WRITE="${INFLUXDB_PROTOCOL}://${INFLUXDB_HOST}:${INFLUXDB_PORT}/write?db=${INFLUXDB_DB}"


#
# Script Settings
#
DEBUG=false
TIMER=1
VAL_TYPE="CNT"   # RND (random value) or CNT (counter)
RANDOM_MAX=1000  # max possible random value
COUNTER=0        # start value for counter
VAL=0

#
# create influx database
#
curl --silent -XPOST ${INFLUXDB_PROTOCOL}://${INFLUXDB_HOST}:${INFLUXDB_PORT}/query \
     --data-urlencode "q=CREATE DATABASE ${INFLUXDB_DB}"

#
# fire the query to the api
#
while true
do
  if [[ ${VAL_TYPE} == "RND" ]]; then
    VAL=$(( ${RANDOM} % ${RANDOM_MAX} ))
  else 
    VAL=$((COUNTER++))
  fi
  
  ${DEBUG} && echo "value: ${VAL:-0} | timestamp: $(date +%N)"

  curl --silent -XPOST ${INFLUXDB_WRITE} \
       --data-binary "${INFLUXDB_KEY} value=${VAL} $(date +%N)"

  sleep ${TIMER}
done

