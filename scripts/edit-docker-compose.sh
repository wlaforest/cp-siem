#!/bin/bash
# Dumb script to edit a template file and replace the ksqldb-server line

# This is a neat trick to find out the public hostname of your EC2 host
PUBLIC_HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/public-hostname)


DEFAULT_COMPOSE="docker-compose.yml"
DOCKER_COMPOSE_FILE="${1:-$DEFAULT_COMPOSE}"


# Run this if you want to (have to) run Confluent Control Center on port 80 and ksqldb server (REST API) on port 443 with no encryption
#/bin/sed -i -e 's/      CONTROL_CENTER_KSQL_KSQLDB1_ADVERTISED_URL: \"http:\/\/localhost:8088\"/      CONTROL_CENTER_KSQL_KSQLDB1_ADVERTISED_URL: \"http:\/\/'$PUBLIC_HOSTNAME':443\"/' -e 's/      - "9021:9021"/      - "80:9021"/' -e 's/      - "8088:8088"/      - "443:8088"/' $DOCKER_COMPOSE_FILE > /home/ubuntu/cp-siem/docker-compose.yml


# Run this if you are sane and can run these services on their default ports (9021 for Confluent Control Center and 8088 for ksqlDB)
/bin/sed -i -e 's/      CONTROL_CENTER_KSQL_KSQLDB1_ADVERTISED_URL: .*$/      CONTROL_CENTER_KSQL_KSQLDB1_ADVERTISED_URL: \"http:\/\/'$PUBLIC_HOSTNAME':8088\"/' $DOCKER_COMPOSE_FILE
