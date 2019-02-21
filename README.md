# myapp-demo
Kubernetes | Python | Apache | Docker | Shellscript

The setup.sh script will install below packages. 
# VirtualBox
# Kubectl
# MiniKube

After installing packages, script will create a pod and service in Kubernetes. Pod contains two simple applications.Service creates a NodePort to access to application.

# App1 
- json file containing "Hello World" message, location /var/www/html/app1
# App2 
- python script, location /var/www/cgi-bin/app2. This script will utilize App1 and displays reversed message text.

All these activiies are automated into a single script file setup.sh. Clone this repo and jut run the script on Ubuntu instance.
# sh setup.sh
