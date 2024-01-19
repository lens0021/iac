#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

apt-get update
apt-get install -y \
  curl \
  fish \
  fzf \
  helix \
  less \
  software-properties-common \
  vim \
;

curl -L https://gitlab.com/-/snippets/3636759/raw/main/authorized_keys -o ~/.ssh/authorized_keys

# Install and configure Docker
# https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
apt-get install -y ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |
  tee /etc/apt/sources.list.d/docker.list >/dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io
systemctl enable docker
systemctl start docker
usermod -a -G docker ubuntu

echo Hello, OCI
