./fetch.bat
docker-compose -f docker-compose-builder.yaml down
docker rmi cka-practice-environment_lab cka-practice-environment_gateone
docker-compose -f docker-compose-builder.yaml up -d

