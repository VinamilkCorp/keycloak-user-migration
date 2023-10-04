ARG KEYCLOAK_IMAGE

FROM $KEYCLOAK_IMAGE
USER root
COPY assets/keycloak-rest-provider.jar /opt/bitnami/keycloak/providers/keycloak-rest-provider.jar
COPY assets/vnm-keycloak-theme  /opt/bitnami/keycloak/themes/vnm-keycloak-theme
USER 1001
ENTRYPOINT [ "/opt/bitnami/scripts/keycloak/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/keycloak/run.sh" ]