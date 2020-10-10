#!/usr/bin/env ash

if [ -z "$(ls -A -- /var/lib/influxdb)" ]; then
	INFLUXDB_HTTP_BIND_ADDRESS=127.0.0.1:8086 INFLUXDB_HTTP_HTTPS_ENABLED=false influxd &
	until influx -host 127.0.0.1 -port 8086 -execute "CREATE DATABASE telegraf"; do echo waiting for influxdb; sleep 2; done
	pkill influxd
fi

exec influxd
