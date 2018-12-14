This is a test broker configured with the certificates from the demo Certificate Authority located in [certs](../certs/) directory.

This configuration assumes that the actual broker is located at `/opt/activemq`. You can change that in [bin/activemq](bin/activemq) script.

The broker is configured to use OCSP reponder to check for the revocation of client certificates, check [conf/activemq.xml](conf/activemq.xml), [conf/java.security](conf/java.security) and [bin/activemq](bin/activemq) on more details on the configuration.

## Broker

To start a broker, execute

	bin/activemq console

To start it with the script on <installation_dir>/bin/activemq, provided with the official download of ActiveMQ, is necessary for the broker to use the OCSP responder that the option `ACTIVEMQ_SSL_OPTS="-Djava.security.properties=$ACTIVEMQ_CONF/java.security"` is set on <installation_dir>/bin/env.

## OCSP

Run OCSP responder from the `certs` directory like

        openssl ocsp -port 2560 -text \        
        -index demoCA/index.txt  -CA demoCA/cacert.pem \
        -rkey demoCA/private/cakey.pem \
        -rsigner demoCA/cacert.pem

## Client

Now you can connect the client to the broker with

	bin/activemq  -Djavax.net.ssl.keyStore=conf/client-1.ks -Djavax.net.ssl.keyStorePassword=activemq \
	-Djavax.net.ssl.trustStore=conf/client-1.ts -Djavax.net.ssl.trustStorePassword=activemq \
	consumer --brokerUrl ssl://localhost:61617

# Debug

If you need to debug SSL behavior, add 

	-Djavax.net.debug=ssl

to the command line.
