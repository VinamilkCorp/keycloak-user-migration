ARG KEYCLOAK_IMAGE

FROM $KEYCLOAK_IMAGE
USER root
COPY assets/keycloak-rest-provider.jar /opt/keycloak/providers/keycloak-rest-provider.jar
USER 1001
ENTRYPOINT [ "/opt/bitnami/scripts/keycloak/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/keycloak/run.sh" ]