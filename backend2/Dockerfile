FROM debian:latest

RUN apt update -y && apt install -y openssh-server python3

COPY ../sshd_config /etc/ssh/sshd_config

COPY ansible/ssh-keys/public/id_rsa.pub /root/.ssh/authorized_keys


EXPOSE 22/tcp
EXPOSE 8080/tcp
EXPOSE 9113/tcp

EXPOSE 9100/tcp
