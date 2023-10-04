ARG KEYCLOAK_IMAGE
ARG MAVEN_IMAGE

FROM keycloak/keycloak:21.0
USER root
COPY --from=builder /tmp/target/*.jar /opt/keycloak/providers/app.jar

COPY docker/assets/vnm-keycloak-theme  /opt/keycloak/themes/vnm-keycloak-theme


USER 1001

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "build", "--spi-email-sender-provider=customSendEmail", "--spi-email-sender-default-enabled=false"]

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--spi-email-sender-provider=customSendEmail", "--spi-email-sender-default-enabled=false"]
