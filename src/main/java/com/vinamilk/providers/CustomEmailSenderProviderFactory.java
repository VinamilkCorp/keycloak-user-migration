package com.vinamilk.providers;

import org.keycloak.Config.Scope;
import org.keycloak.email.EmailSenderProvider;
import org.keycloak.email.EmailSenderProviderFactory;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.KeycloakSessionFactory;

public class CustomEmailSenderProviderFactory implements EmailSenderProviderFactory {


  @Override
  public EmailSenderProvider create(KeycloakSession session) {

    return new CustomEmailSenderProvider();
  }

  @Override
  public void init(Scope config) {

  }

  @Override
  public void postInit(KeycloakSessionFactory factory) { }

  @Override
  public void close() {
  }

  @Override
  public String getId() {
    return "customSendEmail";
  }
}