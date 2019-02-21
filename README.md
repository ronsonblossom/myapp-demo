# myapp-demo
Kubernetes Python Apache Docker Shellscript

The setup.sh script will install below packages. 
# VirtualBox
# Kubectl
# MiniKube

After installing packages, script will clone this repo and create a pod and service in Kubernetes. Pod contains two simple applications.

# App1 
- json file containing "Hello World" message, location /var/www/html/app1
# App2 
- python script, location /var/www/cgi-bin/app2. This script will utilize App1 and displays reversed message text.

All these activiies are automated into a single script file setup.sh. Just run this script on Ubuntu.
# sh setup.sh