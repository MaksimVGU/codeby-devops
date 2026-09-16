#!/bin/bash

set -e

NAME="Max"
DOMAIN="${NAME}.local"
SERVER_IP="192.168.56.11"
CERT_DIR="/etc/ssl/${DOMAIN}"

if [ "$1" = "server" ]; then
    export DEBIAN_FRONTEND=noninteractive

    apt-get update
    apt-get install -y apache2 openssl ca-certificates

    a2enmod ssl
    a2enmod rewrite
    a2dissite 000-default.conf

    mkdir -p "${CERT_DIR}"

    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout "${CERT_DIR}/${DOMAIN}.key" \
        -out "${CERT_DIR}/${DOMAIN}.crt" \
        -subj "/C=RU/ST=Local/L=Local/O=Local/OU=IT/CN=${DOMAIN}" \
        -addext "subjectAltName=DNS:${DOMAIN},DNS:www.${DOMAIN}"

    chmod 600 "${CERT_DIR}/${DOMAIN}.key"
    chmod 644 "${CERT_DIR}/${DOMAIN}.crt"

    cat > "/etc/apache2/sites-available/${DOMAIN}.conf" <<EOF
<VirtualHost *:80>
    ServerName ${DOMAIN}
    ServerAlias www.${DOMAIN}

    RewriteEngine On
    RewriteRule ^ https://${DOMAIN}%{REQUEST_URI} [R=301,L]
</VirtualHost>

<VirtualHost *:443>
    ServerName ${DOMAIN}
    ServerAlias www.${DOMAIN}

    SSLEngine on
    SSLCertificateFile ${CERT_DIR}/${DOMAIN}.crt
    SSLCertificateKeyFile ${CERT_DIR}/${DOMAIN}.key

    RewriteEngine On
    RewriteCond %{HTTP_HOST} ^www\.${DOMAIN//./\\.}$ [NC]
    RewriteRule ^ https://${DOMAIN}%{REQUEST_URI} [R=301,L]

    DocumentRoot /var/www/html

    <Directory /var/www/html>
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF

    a2ensite "${DOMAIN}.conf"

    cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${DOMAIN}</title>
</head>
<body>
    <h1>${DOMAIN}</h1>
</body>
</html>
EOF

    apache2ctl configtest
    systemctl enable apache2
    systemctl restart apache2

elif [ "$1" = "client" ]; then
    export DEBIAN_FRONTEND=noninteractive

    apt-get update
    apt-get install -y ca-certificates curl openssl

    grep -q "${DOMAIN}" /etc/hosts || echo "${SERVER_IP} ${DOMAIN} www.${DOMAIN}" >> /etc/hosts

    until curl -kfsI "https://${DOMAIN}" >/dev/null 2>&1; do
        sleep 2
    done

    while ! openssl s_client -connect "${SERVER_IP}:443" -servername "${DOMAIN}" </dev/null 2>/dev/null | openssl x509 -out "/usr/local/share/ca-certificates/${DOMAIN}.crt"; do
        sleep 2
    done

    update-ca-certificates

    until curl -fsI "https://${DOMAIN}" >/dev/null 2>&1; do
        sleep 2
    done
fi
