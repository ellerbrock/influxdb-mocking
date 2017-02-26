# InfluxDB Mocking

_Quick and dirty hack to get some data to play with into InfluxDB._

## Configuration

```bash
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
```

Thats it - happy mocking!

