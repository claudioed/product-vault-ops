### Connect to the vault pod

```shell script
kubectl exec -ti vault-0 /bin/sh -n vault
```

```shell script
cat <<EOF > /home/vault/app-policy.hcl
path "secret*" {
  capabilities = ["read"]
}
EOF
```

```shell script
vault policy write app /home/vault/app-policy.hcl
```

```shell script
vault auth enable kubernetes
```

```shell script
vault write auth/kubernetes/config \
   token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
   kubernetes_host=https://${KUBERNETES_PORT_443_TCP_ADDR}:443 \
   kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
```

```shell script
vault write auth/kubernetes/role/product-go-vault-sidecar \
   bound_service_account_names=product-go-vault-sidecar \
   bound_service_account_namespaces=sidecar \
   policies=app \
   ttl=10s
```

```shell script
vault kv put secret/product-go-vault-sidecar DB_USER=postgres DB_PASS=mysecretpassword
```