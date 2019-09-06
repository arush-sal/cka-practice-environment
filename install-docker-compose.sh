wget https://www.cnrancher.com/download/compose/v1.23.2-docker-compose-Linux-x86_64

mv v1.23.2-docker-compose-Linux-x86_64 docker-compose
chmod +x docker-compose

mv docker-compose /usr/local/bin/

docker-compose -v

