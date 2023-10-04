ARG KEYCLOAK_IMAGE
ARG MAVEN_IMAGE

FROM maven:3.9.2-eclipse-temurin-17 as builder
COPY pom.xml /tmp/
COPY src /tmp/src
WORKDIR /tmp/
RUN mvn clean package

FROM keycloak/keycloak:21.0
USER root
COPY --from=builder /tmp/target/*.jar /opt/keycloak/providers/app.jar

COPY --from=builder /tmp/src/authen.jar /opt/keycloak/providers/authen.jar

COPY docker/assets/vnm-keycloak-theme  /opt/keycloak/themes/vnm-keycloak-theme


USER 1000

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "build", "--spi-email-sender-provider=customSendEmail", "--spi-email-sender-default-enabled=false"]

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev", "--spi-email-sender-provider=customSendEmail", "--spi-email-sender-default-enabled=false"]
