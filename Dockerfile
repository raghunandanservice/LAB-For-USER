FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Kolkata

RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies tigervnc-standalone-server tigervnc-tools \
    novnc websockify firefox xfce4-terminal thunar \
    sudo curl wget git vim nano unzip zip openssh-client \
    ca-certificates dbus-x11 procps net-tools iproute2 \
    python3 python3-pip openjdk-21-jre \
    gnupg lsb-release apt-transport-https \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash lab && \
    echo 'lab:lab' | chpasswd && usermod -aG sudo lab && \
    echo 'lab ALL=(ALL) NOPASSWD:ALL' >/etc/sudoers.d/lab && chmod 0440 /etc/sudoers.d/lab

# Ansible
RUN pip3 install --break-system-packages ansible

# Terraform
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg -o /tmp/hashicorp.gpg && \
    gpg --dearmor -o /etc/apt/keyrings/hashicorp.gpg /tmp/hashicorp.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(. /etc/os-release && echo $VERSION_CODENAME) main" > /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && apt-get install -y terraform && \
    rm -rf /var/lib/apt/lists/* /tmp/hashicorp.gpg

# Docker Engine (Docker-in-Docker for the lab)
RUN apt-get update && apt-get install -y docker.io && rm -rf /var/lib/apt/lists/*

# Jenkins
RUN curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key -o /usr/share/keyrings/jenkins-keyring.asc && \
    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list && \
    apt-get update && apt-get install -y jenkins && \
    rm -rf /var/lib/apt/lists/*

# Azure CLI / ARM tooling
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

COPY xstartup /home/lab/.vnc/xstartup
COPY start.sh /usr/local/bin/start-lab.sh
RUN chown -R lab:lab /home/lab/.vnc && chmod +x /home/lab/.vnc/xstartup /usr/local/bin/start-lab.sh

EXPOSE 6080 8080
CMD ["/usr/local/bin/start-lab.sh"]
