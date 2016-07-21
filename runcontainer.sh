# Simple shell command that starts up wildfly-admin docker container
# This command executes 2 port mappings:
# 1. from docker 8080 -> to host 9500
# 2. from docker 9990 -> to host 9501
# Yes it looks weird, but those are the values that I use in my environment :)
docker run --name wildfly-admin -p 9500:8080 -p 9501:9990 -d lukastosic/wildfly-admin