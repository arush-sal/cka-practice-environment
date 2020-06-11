wget https://docs.rancher.cn/download/compose/v1.24.1-docker-compose-Linux-x86_64

mv v1.24.1-docker-compose-Linux-x86_64 docker-compose
chmod +x docker-compose

mv docker-compose /usr/local/bin/

docker-compose -v

