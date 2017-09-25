#!/bin/sh

ip=$(echo $1 | awk -F'-' '{print $5"."$6"."$7"."$8}')

until $(curl --output /dev/null --silent --head --fail http://$ip:10350/healthz)
do 
    echo "Waiting for response from http://$ip:10350/healthz"
    sleep 5
done
