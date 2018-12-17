# Digital Ocean Terraform

An example **terraform** digitalocean provider

## Initialize (only once)

```
terraform init
```

## Validate configuration

```
TF_VAR_digitalocean_token="xxxxx" terraform validate
```

## Plan changes

```
TF_VAR_digitalocean_token="xxxxx" terraform plan
```

## Apply changes

```
TF_VAR_digitalocean_token="xxxxx" terraform apply
```
