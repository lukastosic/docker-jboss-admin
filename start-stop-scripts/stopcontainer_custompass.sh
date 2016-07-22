# This command stops and remove continer by name "wildfly-admin-custompass"
# This is docker container name, because that name is used to startup in script startcontainer_custompass.sh
docker stop wildfly-admin-custompass
docker rm wildfly-admin-custompass
