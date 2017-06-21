#!/bin/sh

# clean cache
(while true; do
    sleep "600"
    find /var/cache/opentsdb -mindepth 1 -mmin "+60" -delete;
    echo "$(date -u '+%F %T,000') INFO  cleanup down"
done) &

if [ "${1}" = "" ]; then
    exec /usr/share/opentsdb/bin/tsdb tsd --config /etc/opentsdb/opentsdb.conf
fi

exec /usr/share/opentsdb/bin/tsdb "$@" --config /etc/opentsdb/opentsdb.conf
