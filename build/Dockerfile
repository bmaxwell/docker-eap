FROM trogers/fedora:f20
# Make the above Fedora image yourself - https://github.com/travisrogers05/docker-fedora

MAINTAINER Travis Rogers <travis@redhat.com>

# Copy the EAP to image, unpack and clean up afterwards
ADD jboss-eap-layer.tgz /

RUN groupadd -r jboss && \
useradd -r -g jboss -d /opt/jboss-eap -s /sbin/nologin -c "JBoss user" jboss && \
chown -R jboss:jboss /opt/jboss-eap

# Add a default admin user
RUN ["/opt/jboss-eap/bin/add-user.sh", "--silent=true", "admin", "1@dM1n$;"]

# Link the EAP installation
RUN ln -s /opt/jboss-eap /eap

USER jboss

# Expose ports
EXPOSE 3528 3529 4447 5445 5455 8009 8080 8443 9443 9876 9990 9999

# Specify default values for entry point
CMD ["/eap/bin/launch.sh", "standalone", "-c", "standalone-ha.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
# ENTRYPOINT ["/eap/bin/launch.sh", "standalone", "-c", "standalone-ha.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

