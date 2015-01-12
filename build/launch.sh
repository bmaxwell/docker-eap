#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Usage: $0 <configuration> [options]"
  echo
  echo "Launches JBoss EAP in the selected configuration with specified options (if any)"
  echo
  echo "<configuration>  - standalone or domain"
  echo "[options]        - options accepted by the standalone/domain.sh scripts"
  echo
  echo "Examples:"
  echo
  echo "*  To run JBoss EAP in standalone mode with default options:"
  echo
  echo "   $0 standalone"
  echo
  echo "*  To run JBoss EAP in standalone mode with custom options:"
  echo
  echo "   $0 standalone -b 0.0.0.0"
  exit 1
fi

if [ "$1" = "standalone" ] || [ "$1" = "domain" ]; then
  CONFIGURATION=$1
else
  echo "Only domain and standalone configuration are valid, you provided '$1'. Aborting."
  exit 1
fi

# need to allow this to be variable
JBOSS_HOME=/opt/jboss-eap-6.2

shift 1

$JBOSS_HOME/bin/${CONFIGURATION}.sh $@

# IPADDR=$(ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}')
# $JBOSS_HOME/bin/${CONFIGURATION}.sh -Djboss.bind.address=$IPADDR -Djboss.bind.address.management=$IPADDR $@


