package com.vinamilk.providers;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.vinamilk.dto.SendEmailDto;
import com.vinamilk.http.HttpClient;
import java.util.List;
import java.util.Map;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.LaxRedirectStrategy;
import org.jboss.logging.Logger;
import org.keycloak.email.EmailException;
import org.keycloak.email.EmailSenderProvider;
import org.keycloak.models.UserModel;

public class CustomEmailSenderProvider implements EmailSenderProvider {

  private final HttpClient httpClient;

  private static final Logger log = Logger.getLogger("CustomEmailSenderProvider");

  public CustomEmailSenderProvider() {
    this.httpClient = new HttpClient(HttpClientBuilder.create().setRedirectStrategy(new LaxRedirectStrategy()));
  }

  @Override
  public void send(Map<String, String> config, UserModel user, String subject, String textBody,
      String htmlBody) {
    log.info("attempting to send email for " + user.getEmail());
    log.info("attempting to send email body " + textBody);
    log.info("attempting to send email subject " + subject);
    String integrationUrl = System.getenv().get("INTEGRATION_URL");
    log.info("attempting to send email for " + integrationUrl);

    SendEmailDto sendEmailDto = new SendEmailDto();
    sendEmailDto.setTo(List.of(user.getEmail()));
    sendEmailDto.setSubject(subject);
    sendEmailDto.setBody(htmlBody);
    ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
    String json = null;
    try {
      json = ow.writeValueAsString(sendEmailDto);
    } catch (JsonProcessingException e) {
      throw new RuntimeException(e);
    }

    this.httpClient.post(integrationUrl + "/api/v1/email/send", json);

    log.info("email sent to " + user.getEmail() + " successfully");
  }

  @Override
  public void send(Map<String, String> map, String s, String s1, String s2, String s3)
      throws EmailException {
    log.info("attempting to send email using aws ses for 11111");
    log.info(s);
    log.info(s1);
    log.info(s2);
    log.info(s3);
    log.info("email sent to 1111111 successfully");
  }

  @Override
  public void close() {

  }
}