#! /bin/bash

rm -rf /var/lib/manticore/*

searchd -c /etc/manticoresearch/manticore.conf.sh --nodetach


