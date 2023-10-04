ARG KEYCLOAK_IMAGE
ARG MAVEN_IMAGE

FROM keycloak/keycloak:21.0
USER root

COPY assets/keycloak-rest-provider.jar /opt/bitnami/keycloak/providers/keycloak-rest-provider.jar
COPY assets/vnm-keycloak-theme  /opt/bitnami/keycloak/themes/vnm-keycloak-theme


USER 1001

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "build", "--spi-email-sender-provider=customSendEmail", "--spi-email-sender-default-enabled=false"]

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--spi-email-sender-provider=customSendEmail", "--spi-email-sender-default-enabled=false"]
