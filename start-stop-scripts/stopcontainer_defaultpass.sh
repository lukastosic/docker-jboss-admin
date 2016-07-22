# This command stops and remove continer by name "wildfly-admin-defaultpass"
# This is docker container name, because that name is used to startup in script startcontainer_defaultpass.sh
docker stop wildfly-admin-defaultpass
docker rm wildfly-admin-defaultpass
