LINUX DEVOPS CI/CD GUI LAB
==========================

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

CI/CD Tools:
- Jenkins
- Java 21
- Git

DevOps Tools:
- Ansible
- Terraform
- Docker
- Azure CLI / ARM tooling

BUILD
=====

docker build \
  -t <DOCKERHUB_USERNAME>/linux-devops-cicd-gui-lab:1.0 .

RUN
===

docker run -d --privileged \
  --name cicd-lab \
  -p 6081:6080 \
  -p 8081:8080 \
  -v cicd-jenkins:/var/lib/jenkins \
  <DOCKERHUB_USERNAME>/linux-devops-cicd-gui-lab:1.0

GUI
===

http://localhost:6081

JENKINS
=======

http://localhost:8081

VERIFY
======

java -version

ansible --version

terraform version

docker version

az version


DOCKER HUB
==========

docker login

docker push \
  <DOCKERHUB_USERNAME>/linux-devops-cicd-gui-lab:1.0
