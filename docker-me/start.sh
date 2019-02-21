#!/bin/bash
app1_path="/var/www/html/app1"
app2_path="/var/www/cgi-bin/app2"
##Installing Apache for app1 and required python module for app2
yum -y install httpd python-requests
##Removing if any apache running
rm -rf /run/httpd/* /tmp/httpd*
##Starting apache process
exec /usr/sbin/apachectl -DFOREGROUND
##Setting ownership and permissions
chown apache.apache $app1_path $app2_path
chmod 755 $app2_path

