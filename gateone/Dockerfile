FROM arush/gateone:latest
COPY conf.d/ /etc/gateone/conf.d/
RUN apt-get update && apt-get install wget curl vim openssh-client iputils-ping telnet nmap -y \
	&& curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
	&& chmod +x ./kubectl \
	&& mv ./kubectl /usr/local/bin/kubectl \
	&& ssh-keygen -N "" -t rsa -f ~/.ssh/id_rsa \
        && cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys \
	&& apt-get clean all
