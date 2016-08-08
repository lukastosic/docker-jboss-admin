# Docker image Wildfly with admin account

## What is this ?

This is Docker image that starts up `Wildfly` (version 10).

This image also includes MySQL JDBC connector/driver. 

### But wait, there is already official wildfly image ?

Yes there is, and this one is 99.9% blatant copy-paste of that image. But, as said above: This image also includes MySQL JDBC connector/driver. 

### So what is different ?

This image contains added `docker-entrypoint.sh` file that sets username and password for admin account.

This file looks for environment variables (set by `docker run` command) and if they exist it will use them to set username/password, otherwise it will set defaults.

#### Default admin account

Default username password for admin account is `admin/password`.

#### MySQL JDBC

It contains JDBC file: `mysql-connector-java-5.1.39-bin.jar`.

While building image, this file is copied to image and CLI command is executed to add it as driver.

Then once you start up container you can create datasources using driver `mysql`.

## How to use this image ?

You are more than welcome to download this repository and edit `Dockerfile` to your own liking.

Keep in mind that you will also need file `docker-entrypoint.sh`.

If you want to use it "as-is" you can simply execute docker commands (because image is public on [Docker Hub](http://hub.docker.com)):

* `docker pull lukastosic/wildfly-admin:mysql` to obtain the image
* `docker run lukastosic/wildfly-admin:mysql` to run container

### Run with custom username password

In order to set admin username/password you must _inject_ environment variables into container. You can do that with `-e` switch. Environment variables are:

* `WILDFLY_ADMIN_USERNAME`
* `WILDFLY_ADMIN_PASSWORD`

Your run command with these parameter looks like this:

```
docker run -e WILDFLY_ADMIN_USERNAME=<username> -e WILDFLY_ADMIN_PASSWORD=<password> lukastosic/wildfly-admin:mysql
```

### Run with port mappings

There are 2 ports exposed in docker image:

* `8080` is main access port to `Wildfly`
* `9990` is admin panel of `Wildfly`

In order to run container that maps these ports to your running host you should do standard run command with `-p` switch for every port:

```
docker run --name <name_your_container> -p <your_host_port>:8080 -p <your_host_port>:9990 -d lukastosic/wildfly-admin:mysql
```

for example:

```
docker run --name wildfly-admin -p 9500:8080 -p 9501:9990 -d lukastosic/wildfly-admin:mysql
```

Will start up container with followin properties:

* container name: `wildfly-admin`
* container port `8080` is mapped to host port `9500`
* container port `9990` is mappet to host port `9501`

### Couple of automation scripts

In `git` repository there is folder called `start-stop-scripts` where you can find couple of `.sh` files that can help you quickly start or stop containers.

These scripts contain custom port mappings and they have versions with and without custom password.

These scripts are completely _personal_ (I am using them in that way in my own test/dev environment), so you might find them useless in your workflow.

They are **not needed** for this image to work, so you don't have to copy them, but you might find them useful.

## How to customize this image ?

You can use file `docker-entrypoint.sh` to set custom default username/password combination or to set some other wildfly property.

Other than that, you can use `CLI` script in `customization` folder to set your own custom `CLI` scripts to do some other configuration on server.

Also inside `customization` folder there is script `execute.sh` that is used to start up wildfly server during image build to execute `CLI` commands.

Once you adjust your files you can build image with usual command `docker build .` If you did use custom `CLI` commands, you should see something like this during image build (just to make sure that `CLI` commands are executed):

```
Step 22 : RUN $JBOSS_HOME/customization/execute.sh
 ---> Running in 3017b8cab96f
=> Starting WildFly server
=> Waiting for the server to boot
=> Executing the commands
The batch executed successfully
=> Shutting down WildFly
{"outcome" => "success"}
 ---> a086e192f562
```

## Big thanks to:

* Official wildfly [docker hub](https://hub.docker.com/r/jboss/wildfly/)
* [Marek Goldmann](https://github.com/goldmann), you can see these CLI customizations on his [blog](https://goldmann.pl/blog/2014/07/23/customizing-the-configuration-of-the-wildfly-docker-image/) and in his [github repo](https://github.com/goldmann/wildfly-docker-configuration/tree/master/cli)