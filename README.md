This framework creates a Docker image that contains JBoss EAP.

# Usage

Below you can find instructions on how to build and use the image.

## Preparations

You must have Docker installed. 

## Building

    sudo build/create.sh

## Running

To start in standalone mode and bind to `0.0.0.0` in the background

    sudo bin/run

To start in domain mode and bind to `0.0.0.0` in the background

    sudo bin/run /eap/bin/launch.sh domain -b 0.0.0.0 -bmanagement 0.0.0.0

Edit the `bin/run` script to your liking or execute the `docker run` command with your own options


## Stopping

Use the `docker ps` command to list the running containers
Use the `docker stop <container>` command to stop a running container

## Useful commands

Get the IP address of a running container:
    docker inspect -f '{{ .NetworkSettings.IPAddress }}' <container-name or ID>

Connecting to the domain controller via CLI:

    bin/jboss-cli.sh --controller=172.17.0.12:9999 -c
