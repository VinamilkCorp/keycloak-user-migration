ARG KEYCLOAK_IMAGE

FROM $KEYCLOAK_IMAGE
USER root
COPY assets/keycloak-rest-provider.jar /opt/keycloak/providers/keycloak-rest-provider.jar
USER 1000

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev"]