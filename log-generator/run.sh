#! /bin/bash

if [[ "$REGENERATE_LOG" == "1" ]];
then
	curl http://manticore-for-kibana:9308/cli -d 'CREATE TABLE test(message text, request_path string, http_user_agent string, referer string, time_local string, http_user_agent_version string, username string, ip string, request_method string, @timestamp timestamp, log json, input json, agent json, ecs json, bytes_sent int, status int, host json)'
	# Import Kibana objects to Manticore
	elasticdump --input=./kibana_objects.ndjson --output=http://manticore-for-kibana:9308/.kibana --type=data --transform="doc._source=Object.assign({},doc)"

	# Create a main log
	RATE="10000000" timeout 1000  sh -c './nginx-log-generator | head -n "$LOG_ENTRY_COUNT" > /logs/nginx_main.log'
	echo "Nginx log generated"
fi

if [[ "$LOG_UPDATE_RATE" != "0" ]];
then
	# Create an extra log for adding 'live' log data
	echo "Updating nginx log..."
	RATE="$LOG_UPDATE_RATE" ./nginx-log-generator > /logs/nginx_delta.log
fi
