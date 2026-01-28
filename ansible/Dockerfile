FROM debian:latest

ENV UBUNTU_CODENAME=noble

RUN apt update -y && apt install -y wget gpg openssh-server curl

RUN wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | tee /etc/apt/sources.list.d/ansible.list

RUN apt update -y && apt install -y ansible

COPY ./ansible/ssh-keys/private/id_rsa /root/.ssh/id_rsa

COPY ./sshd_config /etc/ssh/sshd_config

EXPOSE 22
	
WORKDIR /ansible/playbooks


