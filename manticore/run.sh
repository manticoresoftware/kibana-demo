#! /bin/bash

if [[ "$REGENERATE_LOG" == "1" ]];
then
	rm -rf /var/lib/manticore/*
fi

searchd -c /etc/manticoresearch/manticore.conf.sh --nodetach


