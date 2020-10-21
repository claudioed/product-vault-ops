#!/bin/bash

kubectl create ns database

helm repo add bitnami https://charts.bitnami.com/bitnami

sleep 1

helm install postgresql \
  --set global.postgresql.postgresqlDatabase=postgres \
  --set global.postgresql.postgresqlUsername=postgres \
  --set global.postgresql.postgresqlPassword=mysecretpassword \
  --set global.postgresql.servicePort=5432 \
  bitnami/postgresql --namespace database;