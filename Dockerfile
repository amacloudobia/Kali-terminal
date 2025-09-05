# Base
FROM rockylinux:8

# Prep
RUN yum -y install nc net-tools nmap file tcpdump unzip wget
RUN yum -y install epel-release
RUN yum -y install golang
RUN wget https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 && \
    mv ttyd.x86_64 /usr/local/bin/ttyd && \
    chmod +x /usr/local/bin/ttyd
RUN adduser -u 1000 -g 10 centos
RUN adduser -u 1010 -g 10 web
WORKDIR /home/centos

# ... (rest of the Dockerfile remains the same)

# Command
CMD ttyd -p 8080 bash & nc -lkp 31337 -c 'echo FLAG_11314' & nc -lkp 8081 -c 'cat /tmp/.flag_http' & wait

# Ports
EXPOSE 31337 8080 8081
