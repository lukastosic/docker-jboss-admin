# Simple shell command that starts up wildfly-admin docker container with custom admin username/password
# Custom admin username/password are set through evnironment variables (-e switch)
# This command executes 2 port mappings:
# 1. from docker 8080 -> to host 9600
# 2. from docker 9990 -> to host 9601
# Yes it looks weird, but those are the values that I use in my environment :)
docker run --name wildfly-admin-custompass -p 9600:8080 -p 9601:9990 -e WILDFLY_ADMIN_USERNAME=admin -e WILDFLY_ADMIN_PASSWORD=admin123456 -d lukastosic/wildfly-admin:mysql
