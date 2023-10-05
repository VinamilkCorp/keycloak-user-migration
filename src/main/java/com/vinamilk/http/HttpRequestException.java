package com.vinamilk.http;

import com.vinamilk.exceptions.RestUserProviderException;
import org.apache.http.client.methods.HttpUriRequest;

public class HttpRequestException extends RestUserProviderException {

    public HttpRequestException(HttpUriRequest request, Throwable e) {
        super("An error occurred while making a HTTP request: " + request, e);
    }
}
