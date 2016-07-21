# Docker image Wildfly with admin account

## What is this ?

This is Docker image that starts up `Wildfly` (version 10).

### But wait, there is already official wildfly image ?

Yes there is, and this one is 99.9% blatant copy-paste of that image

### So what is different ?

This image has setting for admin username/password and it also starts up management.

As you can see in `Dockerfile` username/password for admin account is `admin/admin123`.

## How to use this image ?

You are more than welcome to download this repo and edit `Dockerfile` to your own liking.

If you want to use it "as-is" you can simply execute docker commands (because image is public on [Docker Hub](http://hub.docker.com)):

* `docker pull lukastosic/wildfly-admin` to obtain the image
* `docker run lukastosic/wildfly-admin` to run container

### Run with port mappings

There are 2 ports exposed in docker image:

* `8080` is main access port to `Wildfly`
* `9990` is admin panel of `Wildfly`

In order to run container that maps these ports to your running host you should do standard run command with `-p` switch for every port:

```
docker run --name <name_your_container> -p <your_host_port>:8080 -p <your_host_port>:9990 -d lukastosic/wildfly-admin
```

for example:

```
docker run --name wildfly-admin -p 9500:8080 -p 9501:9990 -d lukastosic/wildfly-admin
```

Will start up container with followin properties:

* container name: `wildfly-admin`
* container port `8080` is mapped to host port `9500`
* container port `9990` is mappet to host port `9501`

#### Little note about `.sh` files

In order for quick start up and stopping container in my everyday work, I needed to create these 2 files to ease up (automate) that task. 

They are **not needed** for this image to work, so you don't have to copy them, but you might find them useful.