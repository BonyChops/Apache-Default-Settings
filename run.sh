#!/bin/bash -eu
echo "Start configuration..."
sudo su
apt update
apt upgrade -y
apt install -y apache2 php php-cgi libapache2-mod-php php-common php-pear php-mbstring
cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.orig
exit
USERNAME=$(whoami)
cd ~/
set +e
mkdir ~/html
set -e
sudo sed -e "s/<Directory \/var\/www\/html>/<Directory \/home\/$USERNAME\/html>/"  /etc/apache2/apache2.conf.orig > ~/apache2.conf
sudo sed -e "s/Options Indexes FollowSymLinks/Options FollowSymLinks/"   ~/apache2.conf > ~/apache2_1.conf
sudo sed -e "s/AllowOverride None/AllowOverride All/"   ~/apache2_1.conf > ~/apache2_2.conf
sudo cp ~/apache2_2.conf /etc/apache2/apache2.conf
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.orig
sudo sed -e "s/DocumentRoot \/var\/www\/html/DocumentRoot \/home\/$USERNAME\/html/" /etc/apache2/sites-available/000-default.conf > ~/000-default.conf
sudo cp ~/000-default.conf /etc/apache2/sites-available/000-default.conf