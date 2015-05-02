FROM fedora:21

# Using the Fedora 21 base image from the Docker registry.
# You could create your own Fedora base image.  One approach can be found here - https://github.com/travisrogers05/docker-fedora.
# If you would rather not use Docker registry, you can use the docker base image provided by the Fedora project - https://spins.fedoraproject.org/docker/.

MAINTAINER Travis Rogers <travis@redhat.com>

# Execute system update
RUN yum -y update && yum clean all

# Install packages necessary to run EAP and useful packages
RUN yum -y install bind-utils net-tools hostname iputils curl xmlstarlet saxon augeas bsdtar unzip java-1.8.0-openjdk-devel && yum clean all

# Load the EAP installation to the container. Unpack and clean up afterwards
ADD jboss-eap-layer.tgz /

# Add a user to run EAP
RUN groupadd -r jboss && \
useradd -r -g jboss -d /opt/jboss-eap -s /sbin/nologin -c "JBoss user" jboss && \
chown -R jboss:jboss /opt/jboss-eap

# Add a default admin user for EAP
RUN ["/opt/jboss-eap/bin/add-user.sh", "--silent=true", "admin", "1@dM1n$;"]

# Link the EAP installation
RUN ln -s /opt/jboss-eap /eap

USER jboss

# Expose ports
EXPOSE 3528 3529 4447 5445 5455 8009 8080 8443 9443 9876 9990 9999

# Specify default values for entry point
CMD ["/eap/bin/launch.sh", "standalone", "-c", "standalone-ha.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
# ENTRYPOINT ["/eap/bin/launch.sh", "standalone", "-c", "standalone-ha.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
