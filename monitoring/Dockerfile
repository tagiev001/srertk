FROM debian:latest


RUN apt update -y && apt install -y openssh-server python3-apt

COPY ../sshd_config /etc/ssh/sshd_config

COPY ansible/ssh-keys/public/id_rsa.pub /root/.ssh/authorized_keys

EXPOSE 80/tcp
EXPOSE 22/tcp
EXPOSE 8428/tcp
EXPOSE 9090/tcp
EXPOSE 9100/tcp
