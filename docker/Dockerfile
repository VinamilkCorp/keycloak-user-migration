FROM keycloak/keycloak:21.0
USER root

COPY assets/keycloak-rest-provider.jar /opt/keycloak/providers/keycloak-rest-provider.jar
COPY assets/vnm-keycloak-theme  /opt/keycloak/themes/vnm-keycloak-theme

USER 1000

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "build", "--spi-email-sender-provider=customSendEmail", "--spi-email-sender-default-enabled=false"]

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "–-hostname-strict=false", "--spi-email-sender-provider=customSendEmail", "--spi-email-sender-default-enabled=false"]
