This framework creates a Docker image that contains JBoss EAP.

# Usage

Below you can find instructions on how to build and use the image.

## Preparations

You must have Docker installed. 

Clean all unused containers and images: 

	build/bin/docker-rmiu
	build/bin/docker-rmc

## Building

Prepare JBoss EAP archive:

	cd build
	./create.sh

Build docker container:

	sudo docker build --rm -t porkchop_eap_640 .

## Running

#### Standalone:

	sudo docker run -ti --rm --name FOO porkchop_eap_640

**-ti** - Running interactive with a TTY attached.  Could execute as detached processes using -d.  This would require a subsequent `docker stop` command to shutdown a container.


**--rm** - Deleting the container when it is stopped.


**--name FOO** - Provides a "known" name in the Dockersphere.


**porkchop_eap_640** - Using the porkchop_eap_640:latest image


The container has a default CMD that starts a standalone instance.  No further options are required.



#### Domain:

The domain controller and hosts can be started so they use mounted directories from the host as key JBoss EAP directories.  In this example, the `$JBOSS_HOME/domain/configuration` directory for each domain instance point to specific directories on the host.  The provides one alternative to a flexible configuration.


Run DC:

	sudo docker run -ti --rm --name DC -v /docker-eap64/dc/configuration:/opt/jboss-eap/domain/configuration porkchop_eap_640 /eap/bin/launch.sh domain -b 0.0.0.0 -bmanagement 0.0.0.0


**-ti** - Running interactive with a TTY attached.  Could execute as detached processes using -d.  This would require a subsequent `docker stop` command to shutdown a container.


**--rm** - Deleting the container when it is stopped.


**--name DC** - Provides a "known" name in the Dockersphere.


**-v** - Mounts `/opt/jboss-eap-6.4/domain/configuration` in the container to `/docker-eap64/dc/configuration` on the host.  This mount point is RW for the container.  Pay attention, permissions on the host filesystem can cause errors in the container.


**porkchop_eap_640** - Using the porkchop_eap_640:latest image


The remainder of the command line is passed to the container to override the Dockerfile's CMD line.


Run HC1:

	sudo docker run -ti --rm --name HC1 --link DC:HC1 -v /docker-eap64/hc1/configuration:/opt/jboss-eap/domain/configuration porkchop_eap_640 /eap/bin/launch.sh domain -b 0.0.0.0 -bmanagement 0.0.0.0 -Djboss.domain.master.address=<IPofDC>


**--name HC1** - Give this container a unique name.


**--link DC:HC1** - Linking this container to the running DC container for networking visibility.


**-Djboss.domain.master.address=<IPofDC>** - This tells this host where the domain controller resides.  The IP address of the domain controller can be found using `docker inspect` on the DC container.



Run HC2:

	sudo docker run -ti --rm --name HC2 --link DC:HC2 -v /docker-eap64/hc2/configuration:/opt/jboss-eap/domain/configuration porkchop_eap_640 /eap/bin/launch.sh domain -b 0.0.0.0 -bmanagement 0.0.0.0 -Djboss.domain.master.address=<IPofDC>


**--name HC2** - Give this container a unique name.


**--link DC:HC2** - Linking this container to the running DC container for networking visibility.


**-Djboss.domain.master.address=<IPofDC>** - This tells this host where the domain controller resides.  The IP address of the domain controller can be found using `docker inspecti` on the DC container.


## Stopping

Use the `docker ps` command to list the running containers then use the `docker stop <container>` command to stop a running container
Or use Ctrl-c to end the JBoss EAP process

## Useful commands

Get the IP address of a running container:

    docker inspect -f '{{ .NetworkSettings.IPAddress }}' <container-name or ID>


Connecting to the domain controller via CLI:

    bin/jboss-cli.sh --controller=172.17.0.12:9999 -c


