#!/bin/bash
export DEBIAN_FRONTEND=noninteractive       #Prevents any interactive prompts during apt-get install (important for automation).

# Update and install packages
apt-get update -y
apt-get install -y apache2 php php-mysql libapache2-mod-php wget unzip

# Download and setup WordPress
# Moves to the Apache web root.
#Downloads the latest version of WordPress.
#Unzips it.
#Copies all WordPress files to the root web directory.
#Cleans up the ZIP file and temporary folder.

cd /var/www/html
wget https://wordpress.org/latest.zip
unzip latest.zip
cp -r wordpress/* .
rm -rf wordpress latest.zip

# Configure WordPress with DB details
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/${DB_NAME}/" wp-config.php
sed -i "s/username_here/${DB_USER}/" wp-config.php
sed -i "s/password_here/${DB_PASSWORD}/" wp-config.php
sed -i "s/localhost/${DB_HOST}/" wp-config.php

# Set permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Enable Apache and restart
systemctl enable apache2
systemctl restart apache2
