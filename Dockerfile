FROM openjdk:8-jre
MAINTAINER dong@wenqi.us

RUN useradd opentsdb && \
    apt-get update && \
    apt-get install --no-install-recommends -y gnuplot-nox && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    curl -L https://github.com/OpenTSDB/opentsdb/releases/download/v2.3.0/opentsdb-2.3.0_all.deb > /tmp/opentsdb.deb && \
    echo "f72bd4eb6323618435417a4843aca85627e6e24c28f6782c21b96f44e7a3b18ba469e8872d6c583a51f28fb1e843065bfbf501902008841d9a45740e5d0803e5  /tmp/opentsdb.deb" | sha512sum -c && \
    dpkg -i /tmp/opentsdb.deb && \
    rm /tmp/opentsdb.deb && \
    rm /etc/opentsdb/opentsdb.conf && \
    curl -sL "https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64" > /usr/sbin/gosu && \
    chmod +x /usr/sbin/gosu

COPY ./logback.xml /etc/opentsdb/logback.xml
COPY ./opentsdb.conf /etc/opentsdb/opentsdb.conf
COPY ./run.sh /run.sh
COPY ./unprivileged.sh /unprivileged.sh

VOLUME /var/cache/opentsdb

ENTRYPOINT ["/run.sh"]