package com.vinamilk.providers;

import static com.vinamilk.configs.ConfigurationProperties.PROVIDER_NAME;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.vinamilk.configs.ConfigurationProperties;
import com.vinamilk.http.HttpClient;
import com.vinamilk.services.RestUserService;
import com.vinamilk.services.UserModelFactory;
import java.util.List;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.LaxRedirectStrategy;
import org.keycloak.component.ComponentModel;
import org.keycloak.models.KeycloakSession;
import org.keycloak.provider.ProviderConfigProperty;
import org.keycloak.storage.UserStorageProviderFactory;

public class LegacyProviderFactory implements UserStorageProviderFactory<LegacyProvider> {

    @Override
    public List<ProviderConfigProperty> getConfigProperties() {
        return ConfigurationProperties.getConfigProperties();
    }

    @Override
    public LegacyProvider create(KeycloakSession session, ComponentModel model) {
        var userModelFactory = new UserModelFactory(session, model);
        var httpClient = new HttpClient(HttpClientBuilder.create().setRedirectStrategy(new LaxRedirectStrategy()));
        var restService = new RestUserService(model, httpClient, new ObjectMapper());
        return new LegacyProvider(session, restService, userModelFactory, model);
    }

    @Override
    public String getId() {
        return PROVIDER_NAME;
    }
}
