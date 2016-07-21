# This command stops and remove continer by name "wildfly-admin"
# This is docker container name, because that name is used to startup in script startcontainer.sh
docker stop wildfly-admin
docker rm wildfly-admin
