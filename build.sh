#!/bin/bash

git=$(which git)
docker=$(which docker)

kubectl=$(which kubectl)
minikube=$(which minikube)

$minikube start
$minikube addons enable ingress

eval $(minikube docker-env)

$docker build -t ecosia/sre-asst:v1.0 .
$kubectl apply -f k8s/deployment.yml -f k8s/service.yml -f k8s/ingress.yml

printf "\n\n"

sleep 3; echo "Execution complete!"
sleep 2; echo "The deployment and service have been created and is accessible at the following URL."

printf "\n\n"

URL=$($minikube service --url ecosia-svc)
echo "Visit: ${URL}/tree"

sleep 4; printf "\n\n"

echo "The ingress rule has also been created. The IP address returned below should be added to /etc/hosts with the value set to local.ecosia.org"
echo "It may take a few moments for the IP address to be returned."

sleep 30; $kubectl get ingress

printf "\n\n"

sleep 3; echo "Once the local DNS record is created, the JSON output will be visible at local.ecosia.org/tree"
sleep 1; echo "Thank you for taking the time to review!"