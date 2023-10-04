package com.danielfrak.code.keycloak.providers.rest;

import com.vinamilk.configs.ConfigurationProperties;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertNotNull;

class ConfigurationPropertiesTest {

    @Test
    void shouldGetConfigProperties() {
        var result = ConfigurationProperties.getConfigProperties();
        assertNotNull(result);
    }
}