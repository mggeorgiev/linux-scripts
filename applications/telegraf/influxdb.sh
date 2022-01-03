#!/bin/bash

fqdn="fqdn"

curl -G 'http://${fqdn}:8086/query?pretty=true' --data-urlencode "q=SHOW DATABASES"

#influx -precision rfc3339
# CREATE DATABASE "dbs"
# SHOW DATABASES
# USE dbs
# CREATE RETENTION POLICY "30_days" ON "dbs" DURATION 30d REPLICATION 1 DEFAULT;
# CREATE RETENTION POLICY "6_months" ON "dbs" DURATION 26w REPLICATION 1;
# CREATE RETENTION POLICY "infinite" ON "dbs" DURATION INF REPLICATION 1;

# SHOW RETENTION POLICIES

# CREATE CONTINUOUS QUERY "cq_smartmeter_hourly" ON "dbs" RESAMPLE EVERY 15m BEGIN SELECT min(*), max(*), spread(*) INTO "6_months"."smartmeter_hourly" FROM "30_days"."smartmeter" GROUP BY time(1h),* END
# CREATE CONTINUOUS QUERY "cq_smartmeter_daily" ON "dbs" RESAMPLE EVERY 1h BEGIN SELECT min(*), max(*), spread(*) INTO "infinite"."smartmeter_daily" FROM "30_days"."smartmeter" GROUP BY time(1d),* END
# CREATE CONTINUOUS QUERY "cq_weather_daily" ON "dbs" RESAMPLE EVERY 1h BEGIN SELECT min(*), max(*), mean(*) INTO "infinite"."weather_daily" FROM "30_days"."weather" GROUP BY time(1d),* END

# SHOW CONTINUOUS QUERIES