#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

curl -sL https://gitlab.com/-/snippets/3636759/raw/main/authorized_keys | tee -a /home/ubuntu/.ssh/authorized_keys

add-apt-repository -y ppa:maveonair/helix-editor
add-apt-repository -y ppa:openjdk-r/ppa
apt-get update
apt-get install -y \
  curl \
  fish \
  fzf \
  helix \
  htop \
  less \
  software-properties-common \
  tmux \
  vim \
;

# Install and configure Docker
# https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
# apt-get install -y ca-certificates curl gnupg
# install -m 0755 -d /etc/apt/keyrings
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# chmod a+r /etc/apt/keyrings/docker.gpg
# echo \
#   "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
#   "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |
#   tee /etc/apt/sources.list.d/docker.list >/dev/null
# apt-get update
# apt-get install -y docker-ce docker-ce-cli containerd.io
# systemctl enable docker
# systemctl start docker
# usermod -a -G docker ubuntu

adduser --system --home /opt/minecraft minecraft
groupadd minecraft
adduser minecraft minecraft
usermod -a -G minecraft ubuntu
chown -R minecraft:minecraft /opt/minecraft
echo 'eula=true' > /opt/minecraft/eula.txt

echo Hello, OCI
