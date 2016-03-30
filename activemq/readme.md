# Test

## Broker

	bin/activemq console

## Client

	bin/activemq  -Djavax.net.ssl.keyStore=conf/client-1.ks -Djavax.net.ssl.keyStorePassword=activemq \
	-Djavax.net.ssl.trustStore=conf/client-1.ts -Djavax.net.ssl.trustStorePassword=activemq \
	consumer --brokerUrl ssl://localhost:61617

# Debug

-Djavax.net.debug=ssl