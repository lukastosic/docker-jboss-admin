# Use latest jboss/base-jdk:8 image as the base
FROM jboss/base-jdk:8

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 10.0.0.Final
ENV WILDFLY_SHA1 c0dd7552c5207b0d116a9c25eb94d10b4f375549
ENV JBOSS_HOME /opt/jboss/wildfly

# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN cd $HOME \
    && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
    && mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
    && rm wildfly-$WILDFLY_VERSION.tar.gz

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

# Expose the ports we're interested in
EXPOSE 8080

# Setting up entrypoint file that is used to setup username and password
USER root
ADD docker-entrypoint.sh $JBOSS_HOME
ENV MYSQL_JDBC_FOLDER /opt/jboss/wildfly/modules/system/layers/base/com/mysql/driver/main/

# Add MYSQL JDBC connector and script to add datasource driver
CMD ["mkdir $MYSQL_JDBC_FOLDER"]
ADD jdbc-driver/mysql/mysql-connector-java-5.1.39-bin.jar $MYSQL_JDBC_FOLDER
ADD jdbc-driver/mysql/module.xml $MYSQL_JDBC_FOLDER
ADD customization $JBOSS_HOME/customization

RUN chown jboss $JBOSS_HOME/docker-entrypoint.sh
RUN chmod 777 $JBOSS_HOME/docker-entrypoint.sh

VOLUME ["/opt/jboss/wildfly/standalone/deployments"]
VOLUME ["/opt/jboss/wildfly/standalone/log"]

ENTRYPOINT ["/opt/jboss/wildfly/docker-entrypoint.sh"]

# Execute command to set datasource
RUN chmod 777 $JBOSS_HOME/customization/execute.sh
RUN chmod 777 $JBOSS_HOME/customization/commands.cli
RUN $JBOSS_HOME/customization/execute.sh 

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
