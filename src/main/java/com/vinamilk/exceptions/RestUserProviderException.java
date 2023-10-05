package com.vinamilk.exceptions;

public class RestUserProviderException extends RuntimeException {

    public RestUserProviderException(Throwable cause) {
        super(cause);
    }

    public RestUserProviderException(String message, Throwable cause) {
        super(message, cause);
    }
}