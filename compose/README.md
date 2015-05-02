This directory contains Docker Compose files to simulate different scenarios.

## Prerequisites

[Docker Compose](https://docs.docker.com/compose/)


## Files

[eap-domain.yml](eap-domain.yml):
Docker Compose file that creates a JBoss EAP domain environment with a single domain controller and two hosts in a server group.


## Example usage

    docker-compose -f eap-domain.yml up -d

This provides Docker with information related to a set of services (containers) and instructions for
starting each service.

**-f eap-domain.yml** - Specifies a yml file to use.

**up** - Compose command that builds, (re)creates, starts, and attaches to containers for a service.

**-d** - Start the containers in the background and leave them running.
