This is the demo Certificate Authority used for testing and development. This document contains steps used to create all neccessary certificates and explanation on how to create new ones

# Create CA

First to create a Certificate Authority, we used CA.pl helper script from OpenSSL project.

        /System/Library/OpenSSL/misc/CA.pl -newca

This will create demoCA directory with neccessary CA configured. Now we can go on and create certificates.

# Broker

First we need broker certificate

        /System/Library/OpenSSL/misc/CA.pl -newreq
        /System/Library/OpenSSL/misc/CA.pl -sign
        /System/Library/OpenSSL/misc/CA.pl -pkcs12

        mv newcert.pem broker.cert.pem
        mv newcert.p12 broker.p12
        mv newkey.pem broker.key.pem
        rm newreq.pem

Now we can create broker keystore, by adding broker and CA certificates into it. The CA certificate has the default alias "my certificate", given by the `CA.pl` helper script
  
        keytool -importkeystore -srckeystore broker.p12 -destkeystore broker.ks -srcstoretype pkcs12 -alias 'my certificate' -destalias broker
        keytool -import -file demoCA/cacert.pem -alias ca -trustcacerts -keystore broker.ks  

# Client

Let's create a client certificate now

        /System/Library/OpenSSL/misc/CA.pl -newreq
        /System/Library/OpenSSL/misc/CA.pl -sign
        /System/Library/OpenSSL/misc/CA.pl -pkcs12

        mv newcert.pem client-1.cert.pem
        mv newcert.p12 client-1.p12
        mv newkey.pem client-1.key.pem
        rm newreq.pem

and client keystore, by adding client and CA certificates in it        

        keytool -importkeystore -srckeystore client-1.p12 -destkeystore client-1.ks -srcstoretype pkcs12 -alias 'my certificate' -destalias client-1
        keytool -import -file demoCA/cacert.pem -alias ca -trustcacerts -keystore client-1.ks

Now we can create broker and client trust stores, like

        keytool -import -file broker.cert.pem -alias broker -trustcacerts -keystore client-1.ts
        keytool -import -file demoCA/cacert.pem -alias ca -trustcacerts -keystore broker.ts

Note that the broker only has to trust the CA, so all the verifications will be done trhough the OCSP responder

These keystores and truststores are used in ActiveMQ demo.


#OCSP 

To start an OCSP responder, run

        openssl ocsp -port 2560 -text \        
        -index demoCA/index.txt  -CA demoCA/cacert.pem \
        -rkey demoCA/private/cakey.pem \
        -rsigner demoCA/cacert.pem

You can test the responder like

        openssl ocsp -CAfile demoCA/cacert.pem \
        -url http://127.0.0.1:2560 -resp_text \
        -issuer demoCA/cacert.pem \      
        -cert client-1.cert.pem
