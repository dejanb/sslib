# Create CA

        /System/Library/OpenSSL/misc/CA.pl -newca

# Broker

        /System/Library/OpenSSL/misc/CA.pl -newreq
        /System/Library/OpenSSL/misc/CA.pl -sign
        /System/Library/OpenSSL/misc/CA.pl -pkcs12

        mv newcert.pem broker.cert.pem
        mv newcert.p12 broker.p12
        mv newkey.pem broker.key.pem
        rm newreq.pem
  
        keytool -importkeystore -srckeystore broker.p12 -destkeystore broker.ks -srcstoretype pkcs12 -alias 'my certificate' -destalias broker
        keytool -import -file demoCA/cacert.pem -alias ca -trustcacerts -keystore broker.ks  

# Client

        /System/Library/OpenSSL/misc/CA.pl -newreq
        /System/Library/OpenSSL/misc/CA.pl -sign
        /System/Library/OpenSSL/misc/CA.pl -pkcs12

        mv newcert.pem client-1.cert.pem
        mv newcert.p12 client-1.p12
        mv newkey.pem client-1.key.pem
        rm newreq.pem

        keytool -importkeystore -srckeystore client-1.p12 -destkeystore client-1.ks -srcstoretype pkcs12 -alias 'my certificate' -destalias client-1
        keytool -import -file demoCA/cacert.pem -alias ca -trustcacerts -keystore client-1.ks


        keytool -import -file broker.cert.pem -alias broker -trustcacerts -keystore client-1.ts
        keytool -import -file client-1.cert.pem -alias client-1 -trustcacerts -keystore broker.ts
