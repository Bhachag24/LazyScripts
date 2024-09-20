#!/bin/bash

# Set the Redis server and port
REDIS_SERVER="<redis-server-host-name>"
REDIS_PORT="<redis-server-port>"

# Set the name of the Redis set
SET_NAME="<redis-set-name>"

# Set the path to the file to read
FILE_PATH="redis-data-set.txt"

# Set the number of rows to read at a time
ROWS_PER_BATCH=1000

xargs -L $ROWS_PER_BATCH <$FILE_PATH | while read line; do key1=$(echo $line | cut -d "|" -f 1);  printf "\n hset <set-name>:%s %s %s" "${key1: -3}" "${key1}" "${line}"; done | redis-cli -h $REDIS_SERVER -p $REDIS_PORT --pipe
#xargs -L $ROWS_PER_BATCH <$FILE_PATH | while read line; do printf "sadd <redis-set-name>  %s\n"  "${line// /$'\n'}"; done | redis-cli -h $REDIS_SERVER -p $REDIS_PORT --pipe
#xargs -L $ROWS_PER_BATCH <$FILE_PATH | while read line; do  printf "\n del %s" "${line}"; done | redis-cli -h $REDIS_SERVER -p $REDIS_PORT --pipe
