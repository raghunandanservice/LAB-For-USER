LINUX DEVOPS KUBERNETES GUI LAB
================================

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

DevOps Tools:
- Docker
- Jenkins
- Java 21
- Ansible
- Git

Kubernetes Tools:
- kubectl
- Helm
- kind

BUILD
=====

docker build \
  -t <DOCKERHUB_USERNAME>/linux-devops-k8s-gui-lab:1.0 .

RUN
===

docker run -d --privileged \
  --name k8s-lab \
  -p 6082:6080 \
  -p 8082:8080 \
  -v k8s-jenkins:/var/lib/jenkins \
  <DOCKERHUB_USERNAME>/linux-devops-k8s-gui-lab:1.0

GUI
===

http://localhost:6082

JENKINS
=======

http://localhost:8082

CREATE KUBERNETES CLUSTER
=========================

kind create cluster

CHECK CLUSTER:

kubectl get nodes

CHECK KUBECTL:

kubectl version --client

CHECK HELM:

helm version

CHECK KIND:

kind version

CHECK DOCKER:

docker version

CHECK ANSIBLE:

ansible --version


DOCKER HUB
==========

docker login

docker push \
  <DOCKERHUB_USERNAME>/linux-devops-k8s-gui-lab:1.0
