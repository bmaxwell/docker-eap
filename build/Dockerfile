FROM trogers/fedora:f20

MAINTAINER Travis Rogers <travis@redhat.com>

# Copy the EAP to image, unpack and clean up afterwards
ADD jboss-eap-6.2.3-layer.zip /opt/
RUN unzip -q /opt/jboss-eap-6.2.3-layer.zip -d /

# Remove unneeded zip files
RUN rm /opt/jboss-eap*.zip

RUN groupadd -r jboss && \
useradd -r -g jboss -d /opt/jboss-eap-6.2 -s /sbin/nologin -c "JBoss user" jboss && \
chown -R jboss:jboss /opt/jboss-eap-6.2

# Add a default admin user
RUN ["/opt/jboss-eap-6.2/bin/add-user.sh", "--silent=true", "admin", "1Redhat;"]

# Link the EAP installation
RUN ln -s /opt/jboss-eap-6.2 /eap

# Add the launch script
# ADD launch /opt/jboss-eap-6.2/bin/
#
# duplicated by create.sh script adding launch.sh

USER jboss

# Expose ports
EXPOSE 4447 8080 9990 9999

# Specify default values for entry point
CMD ["/eap/bin/launch.sh", "standalone", "-c", "standalone-ha.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
# ENTRYPOINT ["/eap/bin/launch.sh", "standalone", "-c", "standalone-ha.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

