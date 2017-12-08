# sslib

Library containing useful SSL tools for Java developers

It contains:

* A Certificate Authority used for testing and development. You can find more info on it in the [certs](certs/) directory.
* A demo broker configuration configured to use OCSP responder for checking client certificates in [activemq](activemq/) directory.

# Useful information
All passwords of certificates, keystores and truststores are `activemq`.

If you encounter the error `java.security.cert.CertPathValidatorException: validity check failed` on the broker, check the expiration date of the certificates. For that, you can use `openssl x509 -noout -enddate -in <path to cert.pem>`
