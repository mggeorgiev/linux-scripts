#!/bin/bash

docker pull grafana/grafana
#docker pull influxdb
docker pull influxdb:1.8
docker pull telegraf

sudo mkdir /opt/monitoring && cd /opt/monitoring

cat << EOF >> docker-compose.yml
version: "2"
services:
    grafana:
        image: grafana/grafana
        container_name: grafana
        restart: always
        ports:
            - 3000:3000
        networks:
            - monitoring
        volumes:
            - grafana-volume:/var/lib/grafana
    influxdb:
        image: influxdb:1.8
        container_name: influxdb
        restart: always
        ports:
            - 8086:8086
        networks:
            - monitoring
        volumes:
            - influxdb-volume:/var/lib/influxdb
    telegraf:
        container_name: telegraf
        image: telegraf
        networks:
            - monitoring
        volumes:
            - telegraf-volume:/etc/telegraf/telegraf.conf:ro
networks:
    monitoring:
volumes:
    grafana-volume:
        external: true
    influxdb-volume:
        external: true
    telegraf-volume:
EOF

docker network create monitoring
docker volume create grafana-volume
docker volume create influxdb-volume

sudo mkdir /var/lib/influxdb
sudo mkdir /var/lib/grafana

password=$(cat ~/userpass.txt)
docker run -d \
--name influxdb \
-e INFLUXDB_DB=telegraf \
-e INFLUXDB_ADMIN_ENABLE=true \
-e INFLUXDB_ADMIN_USER=admin \
-e INFLUXDB_ADMIN_PASSWORD=$password \
-e INFLUXDB_USER=telegraf \
-e INFLUXDB_USER_PASSWORD=$password \
-v influxdb-volume:/var/lib/influxdb \
influxdb:1.8 /init-influxdb.sh

sudo mkdir /etc/telegraf && cd /etc/telegraf

docker run --rm telegraf telegraf config > telegraf.conf

### GRAFANA ###

docker run -d -p 3000:3000 -v grafana-volume:/var/lib/grafana --network="monitoring" --restart=always --name grafana grafana/grafana

### INFLUX ###
docker run --rm influxdb:1.8 influxd config > influxdb.conf
password=$(cat ~/userpass.txt)
docker run -d \
--name influxdb \
-p 8086:8086 \
-e INFLUXDB_DB=telegraf \
-e INFLUXDB_ADMIN_ENABLED=true \
-e INFLUXDB_ADMIN_USER=admin \
-e INFLUXDB_ADMIN_PASSWORD=$password \
-e INFLUXDB_USER=telegraf \
-e INFLUXDB_USER_PASSWORD=$password \
-v influxdb-volume:/var/lib/influxdb \
--restart=always \
--network="monitoring" \
influxdb:1.8