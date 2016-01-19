#!/bin/bash

# Creates private key for a client

# expects as arguments:
# 1. ca_loc 2. username 3. email 4. password

ca_loc=$1
username=$2
email=$3
client_password=$4

# ca_loc=/home/lively/lively-web.org/http/ssl/lively-web-CA
# username="robertkrahn"
# email="robert.krahn@gmail.com"
# client_password="...."
# ./register-cert.sh /home/lively/lively-web.org/http/ssl/lively-web-CA robertkrahn "robert.krahn@gmail.com" ****

echo -e "Creating private key file for ${username} of CA ${ca_loc}"

mkdir -p $ca_loc
mkdir -p $ca_loc/private
mkdir -p $ca_loc/csr
mkdir -p $ca_loc/certs

cd $ca_loc;

if [[ ! -f "$ca_loc/openssl.cnf" ]]; then
  echo "No $ca_loc/openssl.cnf exists, see /etc/ssl/openssl.cnf for an example."
  exit 1;
fi

echo "1. generating private/client_$username.key"
openssl genrsa -des3 \
    -passout pass:"$client_password" \
    -out "private/client_$username.key" 2048
 
# Remove passphrase 
echo "2. removing passphrase from private/client_$username.key"
openssl rsa \
    -passin pass:"$client_password" \
    -in "private/client_$username.key" \
    -out private/client_$username.key
 
# Create CSR for the client.
echo "3. create client csr csr/client_$username.csr"
openssl req -config openssl.cnf -new \
    -subj "/C=US/L=San Francisco/O=livelyweb-internal/CN=$username/emailAddress=$email" \
    -key "private/client_$username.key" \
    -out "csr/client_$username.csr"

# Create client certificate.
echo "4. create client certificate. certs/client_$username.crt"
openssl ca -batch -config openssl.cnf \
    -days 365 \
    -in "csr/client_$username.csr" \
    -out "certs/client_$username.crt" \
    -keyfile private/rootCA.key -cert certs/rootCA.crt -policy policy_anything

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# 5. Export the client certificate to pkcs12
echo "5. export the client certificate to pkcs12 certs/client_$username.p12"
openssl pkcs12 -export \
    -passout pass:"$client_password" \
    -in "certs/client_$username.crt" \
    -inkey "private/client_$username.key" -certfile certs/rootCA.crt \
    -out "certs/client_$username.p12"
