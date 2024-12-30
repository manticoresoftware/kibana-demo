#! /bin/bash

# Adding a log preprocess pipeline to Elastic
curl -H 'Content-Type: application/json' -XPUT 'http://elastic-for-kibana:9200/_ingest/pipeline/preprocess' -d '{"description" : "preprocessing nginx log data","processors" : [{"geoip" : {"field" : "ip"}},{"date" : {"field" : "time_local","target_field" : "time_local", "formats" : ["dd/MMM/yyyy:HH:mm:ss Z"]} }]}'

filebeat -e -strict.perms=false
