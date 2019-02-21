#!/bin/sh
##Variables
url=`minikube service myapp-service  --url`
app1path="/app1"
app2path="/cgi-bin/app2"
app1url=$url$app1path
app2url=$url$app2path

##UPDATE UBUNTU DEPENDENCIES
apt-get update
apt-get install -y apt-transport-https

##INSTALL VIRTUALBOX ON UBUNTU
echo virtualbox-ext-pack virtualbox-ext-pack/license select true | sudo debconf-set-selections
apt-get install -y virtualbox virtualbox-ext-pack

##INSTALL KUBECTL
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo touch /etc/apt/sources.list.d/kubernetes.list 
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

##INSTALL MINIKUBE
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube && sudo mv minikube /usr/local/bin/

##START MINIKUBE
minikube start

##WAITING FOR MINIKUBE TO COMEUP
Sleep 30

##DOCKER INSTALLATION IF REQUIRED ONLY
#apt-get install -y docker.io

##CLONE CODES FROM GITHUB NOTE: DOCKER FILES ARE ALSO UPLOADED TO THIS GIT REPO
git clone https://github.com/ronsonblossom/myapp-demo.git

##CREATE POD AND SERVICE IN K8S
kubectl create -f myapp-demo/kubernetes-me/myapp.yml

##WAITING FOR PODS
while :
do
	status=`kubectl get pods | grep -w "myapp.example.com" | awk '{print $3}'`
	echo "Pods status is $status"
	if [ "$status" = "Running" ]; then
		break
	fi
	sleep 10
done

##WAITING FOR APPLICATION
while :
do
	status=`curl -o /dev/null -s -w "%{http_code}\n"  $app1url`
	echo "Checking application status, response is $status"
	if [ $status -eq 200 ]; then
		echo "Application is now available !!!"
		break
	fi
	sleep 10
done

##DISPLAY APPLICATIONS

echo "###################APP1###################"
curl $app1url
echo "###################END####################"
echo
echo
echo "###################APP2###################"
curl $app2url
echo "###################END####################"


