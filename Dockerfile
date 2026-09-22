FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Kolkata

RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies \
    tigervnc-standalone-server tigervnc-tools \
    novnc websockify \
    firefox \
    xfce4-terminal thunar \
    sudo curl wget git vim nano unzip zip \
    openssh-client ca-certificates dbus-x11 procps net-tools iproute2 \
    python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash lab && \
    echo 'lab:lab' | chpasswd && \
    usermod -aG sudo lab && \
    echo 'lab ALL=(ALL) NOPASSWD:ALL' >/etc/sudoers.d/lab && \
    chmod 0440 /etc/sudoers.d/lab

COPY xstartup /home/lab/.vnc/xstartup
RUN chown -R lab:lab /home/lab/.vnc && chmod +x /home/lab/.vnc/xstartup

COPY start.sh /usr/local/bin/start-lab.sh
RUN chmod +x /usr/local/bin/start-lab.sh

EXPOSE 6080
CMD ["/usr/local/bin/start-lab.sh"]

# Java course tools
RUN apt-get update && apt-get install -y \
    openjdk-21-jdk maven \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH=${JAVA_HOME}/bin:${PATH}

WORKDIR /home/lab
