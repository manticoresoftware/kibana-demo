#! /bin/bash

# Read env variables
while read -r line || [ -n "$line" ]; do eval $line; done < .env

# Pass saved Kibana objects for future import
if [ ! -f "./log-generator/kibana_objects.ndjson" ];
then
	cp -r ./kibana_objects.ndjson ./log-generator/kibana_objects.ndjson	
fi

ES_DATA_DIR="es_data"
MANTICORE_DATA_DIR="manticore_data"

ES_DATA_DIR=$ES_DATA_DIR MANTICORE_DATA_DIR=$MANTICORE_DATA_DIR docker-compose up
