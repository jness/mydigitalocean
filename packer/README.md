# Digital Ocean Packer

An example **packer** digitalocean builder

## Test provision scripts locally using docker

```
docker build . -t packer
```

## Build provisioned snapshot on digitalocean

```
DIGITALOCEAN_API_TOKEN="xxxxx" packer build packer.json
```
