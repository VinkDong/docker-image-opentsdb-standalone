#!/bin/bash

set -e

export TSD_ROOT_LOG_LEVEL=${TSD_ROOT_LOG_LEVEL:-INFO}
export TSD_QUERY_LOG_LEVEL=${TSD_QUERY_LOG_LEVEL:-INFO}


sed "s/{{ROOT_LOG_LEVEL}}/${TSD_ROOT_LOG_LEVEL}/"   -i /etc/opentsdb/logback.xml
sed "s/{{QUERY_LOG_LEVEL}}/${TSD_QUERY_LOG_LEVEL}/" -i /etc/opentsdb/logback.xml

chown opentsdb /var/cache/opentsdb

exec gosu opentsdb /unprivileged.sh "$@"
