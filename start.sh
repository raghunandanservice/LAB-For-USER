#!/bin/bash
set -e

mkdir -p /tmp/.X11-unix /home/lab/.vnc
chown -R lab:lab /home/lab

# Start VNC desktop
su - lab -c "tigervncserver :1 -geometry 1440x900 -depth 24 -localhost no -SecurityTypes None" >/var/log/vnc.log 2>&1 || true

# Start Jenkins when installed in this image
if [ -f /usr/share/jenkins/jenkins.war ]; then
  mkdir -p /var/lib/jenkins
  chown -R jenkins:jenkins /var/lib/jenkins
  if ! pgrep -f 'jenkins.war' >/dev/null 2>&1; then
    su -s /bin/bash - jenkins -c 'nohup java -jar /usr/share/jenkins/jenkins.war --httpPort=8080 >/var/log/jenkins.log 2>&1 &' || true
  fi
fi

# Start Docker daemon when available. The container must run --privileged.
if command -v dockerd >/dev/null 2>&1; then
  if ! pgrep -x dockerd >/dev/null 2>&1; then
    nohup dockerd --host=unix:///var/run/docker.sock >/var/log/dockerd.log 2>&1 &
    sleep 3
  fi
fi

# noVNC
exec /usr/share/novnc/utils/novnc_proxy --vnc localhost:5901 --listen 6080
