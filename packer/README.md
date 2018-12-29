# Digital Ocean Packer

Use **packer** to build digitalocean base images


## Build web base image

```
DIGITALOCEAN_API_TOKEN="xxxxx" packer -var "version=xxx" build packer_web.json
```

## Build database base image

```
DIGITALOCEAN_API_TOKEN="xxxxx" packer -var "version=xxx" build packer_database.json
```
