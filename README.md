LINUX JAVA GUI LAB
==================

Base OS:
Ubuntu 24.04

GUI:
XFCE Desktop
TigerVNC
noVNC

Applications:
- Firefox
- Terminal
- File Manager

Development Tools:
- Java JDK 21
- Maven
- Git
- curl
- wget
- vim
- nano

BUILD
=====

docker build -t <DOCKERHUB_USERNAME>/linux-java-gui-lab:1.0 .

RUN
===

docker run -d \
  --name java-lab \
  -p 6080:6080 \
  <DOCKERHUB_USERNAME>/linux-java-gui-lab:1.0

ACCESS
======

Open:

http://localhost:6080

Linux user:

lab

Password:

lab

VERIFY JAVA
===========

java -version

mvn -version

git --version


DOCKER HUB
==========

docker login

docker tag <DOCKERHUB_USERNAME>/linux-java-gui-lab:1.0 \
  <DOCKERHUB_USERNAME>/linux-java-gui-lab:latest

docker push <DOCKERHUB_USERNAME>/linux-java-gui-lab:1.0

docker push <DOCKERHUB_USERNAME>/linux-java-gui-lab:latest
