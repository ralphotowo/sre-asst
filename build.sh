#!/bin/bash

git=$(which git)
docker=$(which docker)

kubectl=$(which kubectl)
minikube=$(which minikube)

minikube start
minikube addons enable ingress

eval $(minikube docker-env)
docker build -t ecosia/sre-asst:v1.0 .

kubectl apply -f k8s/deployment.yml -f k8s/service.yml

