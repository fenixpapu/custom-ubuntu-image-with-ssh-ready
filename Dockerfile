FROM ubuntu:20.04

RUN mkdir -p /var/run/sshd


RUN apt update && \
  apt install -y openssh-server

RUN useradd -rm -d /home/ubuntu -s /bin/bash ubuntu && \
  echo ubuntu:password1234 | chpasswd

RUN mkdir /home/ubuntu/.ssh && \
  chmod 700 /home/ubuntu/.ssh

COPY id_rsa.pub /home/ubuntu/.ssh/authorized_keys


RUN chown ubuntu:ubuntu -R /home/ubuntu/.ssh && \
  chmod 600 /home/ubuntu/.ssh/authorized_keys

CMD ["/usr/sbin/sshd", "-D"]