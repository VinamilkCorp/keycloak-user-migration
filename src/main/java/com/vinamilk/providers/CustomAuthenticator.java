package com.vinamilk.providers;

import static com.vinamilk.utils.DeviceHelper.VALID_EMAILS;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.openshift.internal.restclient.model.kubeclient.User;
import com.vinamilk.dto.Customer;
import javax.ws.rs.core.MultivaluedHashMap;
import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.AuthenticationFlowError;
import org.keycloak.authentication.Authenticator;
import org.keycloak.events.Details;
import org.keycloak.events.EventType;
import org.keycloak.forms.login.LoginFormsProvider;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;
import org.keycloak.models.utils.FormMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.core.Response;
import java.io.IOException;


public class CustomAuthenticator implements Authenticator {

  private final Logger log = LoggerFactory.getLogger(CustomAuthenticator.class);

  private ObjectMapper objectMapper = new ObjectMapper();

  private final KeycloakSession session;

  public CustomAuthenticator(KeycloakSession session) {
    this.session = session;
  }

  /**
   * Method is used for user authentication. It makes a call to an external API that returns a jwt token if the user is authenticated
   * If the user is authenticated an authenticated user is set.
   * Whereas if the user is not authenticated, an error is set.
   * @param context
   */
  @Override
  public void authenticate(AuthenticationFlowContext context) {
    log.info("CUSTOMER PROVIDER authenticate");
    log.info(String.valueOf(context));
    MultivaluedMap<String, String> formData = new MultivaluedHashMap<>();

    try {
      UserModel userModel = context.getSession().users().getUserByUsername(context.getRealm(), "datle");
      log.info("CUSTOMER PROVIDER authenticate 02");
      log.info(String.valueOf(userModel));

      if (userModel == null) {

        Response challengeResponse = challenge(context, formData);
        context.challenge(challengeResponse);
        return;
      }
      //userModel.grantRole(context.getRealm().getRole("user"));
      context.setUser(userModel);
      context.success();

//            formData = context.getHttpRequest().getDecodedFormParameters();
//            String username = formData.getFirst("username");
//            String password = formData.getFirst("password");
//            log.debug("AUTHENTICATE custom provider: " + username);
//
//            User user = null;
//            try {
//                user = callExternalApi(username, password);
//            } catch (IOException e) {
//                log.error("Errore durante la chiamata all'API esterna", e);
//                context.failure(AuthenticationFlowError.INTERNAL_ERROR);
//                return;
//            }
//
//            if (user != null) {
//                try {
//                    UserModel userModel = context.getSession().users().getUserByUsername(context.getRealm(), user.getUsername());
//                    if (userModel == null) {
//                        // create user if not exists
//                        userModel = context.getSession().users().addUser(context.getRealm(), user.getUsername());
//                    }
//                    userModel.setEmail(user.getEmail());
//                    userModel.setFirstName(user.getFirstName());
//                    userModel.setLastName(user.getLastName());
//                    userModel.setEnabled(true);
//                    userModel.setSingleAttribute("extra-key", "extra-value");
//                    for (String role : user.getRoles()) {
//                        userModel.grantRole(context.getRealm().getRole(role));
//                    }
//                    //userModel.grantRole(context.getRealm().getRole("user"));
//                    context.setUser(userModel);
//                }
//                catch (Exception e) {
//                    log.error("Authentication error", e);
//                    context.failure(AuthenticationFlowError.INTERNAL_ERROR);
//                }
//                context.success();
//            } else {
//                // User not authenticated set unauthorized error
//                context.failure(AuthenticationFlowError.INVALID_USER, Response.status(Response.Status.UNAUTHORIZED)
//                    .entity("You must be authenticated to access this resource.")
//                    .build());
//                return;
//            }
    } catch (Exception exception) {
      Response challengeResponse = challenge(context, formData);
      context.challenge(challengeResponse);
    }
    // It is also possible to use the challenge() method to request the user to provide further information to complete the authentication.
  }

  protected Response challenge(AuthenticationFlowContext context, MultivaluedMap<String, String> formData) {
    LoginFormsProvider forms = context.form();

    if (formData.size() > 0) forms.setFormData(formData);

    return forms.createLoginUsernamePassword();
  }

  /**
   * Call to external API for authentication
   * @param username Username of the user
   * @param password Password of the user
   * @return User authenticated
   * @throws IOException
   */
  private User callExternalApi(String username, String password) throws IOException {
//    CustomExternalApi customExternalApi = new CustomExternalApi();
//    String token = customExternalApi.getTokenAuthenticateToExternalApi(username, password);
//    if(token == null) {
//      return null;
//    }
//    UserResponseDTO userResponseDTO = customExternalApi.getProfileToExternalApi(token);
    return new User();
  }

  @Override
  public void action(AuthenticationFlowContext context) {
    log.info("CUSTOMER PROVIDER action 11");
    log.info(String.valueOf(context));

    MultivaluedMap<String, String> formData = context.getHttpRequest().getDecodedFormParameters();
    log.info("============");
    log.info(String.valueOf(formData));
    log.info("============");
    String email = formData.getFirst("username");
    log.info("============ email");
    log.info(email);

    // Todo: call auth service to login
    Customer customer = VALID_EMAILS.stream().filter(f -> f.getEmail().equals(email)).findFirst().orElse(null);

    if (customer == null) {
      Response response = context.form()
          .addError(new FormMessage("EMAIL_NOT_FOUND"))
          .createLoginUsernamePassword();
      context.failureChallenge(AuthenticationFlowError.INVALID_USER, response);
      return;
    }

    KeycloakSession session = context.getSession();
    RealmModel realm = context.getRealm();
    UserModel user = session.users().addUser(realm, email);
    user.setEnabled(true);
    user.setEmail(email);
    user.setFirstName(customer.getFirstName());
    user.setLastName(customer.getLastName());

    context.setUser(user);

    context.getEvent().user(user);
    context.getEvent().success();
    context.newEvent().event(EventType.LOGIN);

    context.getEvent().client(context.getAuthenticationSession().getClient().getClientId())
        .detail(Details.REDIRECT_URI, context.getAuthenticationSession().getRedirectUri())
        .detail(Details.AUTH_METHOD, context.getAuthenticationSession().getProtocol());

    String authType = context.getAuthenticationSession().getAuthNote(Details.AUTH_TYPE);
    if (authType != null) {
      context.getEvent().detail(Details.AUTH_TYPE, authType);
    }
    context.success();
  }

  @Override
  public boolean requiresUser() {
    return false;
  }

  @Override
  public boolean configuredFor(KeycloakSession session, RealmModel realm, UserModel user) {
    return true;
  }

  @Override
  public void setRequiredActions(KeycloakSession session, RealmModel realm, UserModel user) {
    // Set the required actions for the user after authentication
  }

  @Override
  public void close() {
    // Closes any open resources
  }
}
