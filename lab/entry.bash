#!/bin/bash

envsubst '${GATEONE_HTTP_SERVER}' < /etc/nginx/nginx.template > /etc/nginx/nginx.conf
cat /etc/nginx/nginx.conf

if [ $# = 0 ]
then
    exec nginx -g 'daemon off;'
else
    exec "$@"
fi
