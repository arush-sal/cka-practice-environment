# cka-practice-environment

## the MOSTLY DIFFERENCE from the original repo
thw orginal repo [arush-sal/cka-practice-environment](https://github.com/arush-sal/cka-practice-environment) 
- only support visit the CKA practice environment with URL `http://localhost` or `http://127.0.0.1`, that's **TOO BAD**, cause this constraint, you can **only use MacBook or CentOS/Ubuntu Desktop verison**, if you wanna use a VM on a Cloud, and visit the environment from your local browser, there is no way for you.
- and based on my fork, you can **provision the CKA practice environment on a Cloud VM, than visit it with its PUBLIC IP from your local browser**, that's pretty cool

## Quick Start (needn't clone the repo)
**you must install docker before do this**. just copy and paste these shells, then visit it from your local browser
```
export PUBLIC_IP=47.52.219.131
export PRIVATE_IP=172.31.63.194

# install docker-compose 
wget https://www.cnrancher.com/download/compose/v1.23.2-docker-compose-Linux-x86_64
mv v1.23.2-docker-compose-Linux-x86_64 docker-compose
chmod +x docker-compose
mv docker-compose /usr/local/bin/
docker-compose -v

# provision k8s (k3s)
curl -sfL https://get.k3s.io | sh -

# check it
kubectl get node

# release port 80
kubectl -n kube-system delete ds svclb-traefik
kubectl -n kube-system delete job helm-install-traefik
kubectl -n kube-system delete ds svclb-traefik
kubectl -n kube-system delete deploy traefik

# copy kubeconfig to /root/.kube/config
cp /etc/rancher/k3s/k3s.yaml /root/.kube/config
sed -i "s/localhost/$(echo $PRIVATE_IP)/g" /root/.kube/config

kubectl --kubeconfig /root/.kube/config get node

# gen docker-compose.yaml and up it
cat > docker-compose.yaml << EOF
version: "3"

services:

  gateone:
    image: satomic/gateone:http
    ports:
    - "8000:8000"
    hostname: kubectl
    networks:
    - frontend
    volumes:
    - ssh_key:/root/.ssh/
    - /root/.kube/:/root/.kube/

  lab:
    image: satomic/cka_lab
    entrypoint: /opt/entry.bash
    ports:
      - 80:80
    networks:
    - frontend
    environment:
      GATEONE_HTTP_SERVER: "${PUBLIC_IP}:8000" # you need to change this IP based on your real env

networks:
  frontend: {}
volumes:
  ssh_key: {}
EOF

docker-compose up -d

docker ps -a | grep satomic

```



## Getting the environment up and ready

### 1. install `docker-compose`
Make sure that you have docker-compose installed([installation instructions](https://docs.docker.com/compose/install/)). Or you can run the `install-docker-compose.sh` shell scripts.
```
sh install-docker-compose.sh
```

### 2. up it

assume the **PUBLIC IP/PRIVATE IP** of your host (maybe a VM) is `47.52.219.131/172.31.63.194`, you need to change the `environment` values of `GATEONE_HTTP_SERVER` in the file `docker-compose.yaml` or `docker-compose-builder.yaml`

example:
```
version: "3"

services:

  gateone:
    image: satomic/gateone:http
    ports:
    - "8000:8000"
    hostname: kubectl
    networks:
    - frontend
    volumes:
    - ssh_key:/root/.ssh/

  lab:
    image: satomic/cka_lab
    entrypoint: /opt/entry.bash
    ports:
      - 80:80
    networks:
    - frontend
    environment:
      GATEONE_HTTP_SERVER: "47.52.219.131:8000" # you need to change this IP based on your real PUBLIC IP

networks:
  frontend: {}
volumes:
  ssh_key: {}
```
 
To start the lab environment you can do either of the following two:

#### To use the prebuilt images
run
```
docker-compose up -d
```
and point your browser to `http://47.52.219.131`

#### To build the images yourself locally 
run
```
docker-compose -f docker-compose-builder.yml up -d
```
and point your browser to `http://47.52.219.131`


### 3. provision k8s (k3s)
```
export PRIVATE_IP=172.31.63.194
curl -sfL https://get.k3s.io | sh -

# check it
kubectl get node

# release port 80
kubectl -n kube-system delete ds svclb-traefik
kubectl -n kube-system delete job helm-install-traefik
kubectl -n kube-system delete ds svclb-traefik
kubectl -n kube-system delete deploy traefik

# copy kubeconfig to /root/.kube/config
cp /etc/rancher/k3s/k3s.yaml /root/.kube/config
sed -i "s/localhost/$(echo $PRIVATE_IP)/g" /root/.kube/config

kubectl --kubeconfig /root/.kube/config get node
```

## uninstall
```
docker-compose down
/usr/local/bin/k3s-uninstall.sh
```