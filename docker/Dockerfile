ARG KEYCLOAK_IMAGE

FROM $KEYCLOAK_IMAGE
USER root
COPY assets/*.jar /opt/keycloak/providers/app.jar
USER 1000

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev"]