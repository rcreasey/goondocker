#!/bin/sh

echo "Installing Docker in base image"
pacman --noconfirm -S docker

cat >./docker.service <<EOF
[Service]
ExecStart=/usr/bin/docker -d -g /var/lib/docker/ -H unix:// -H tcp://0.0.0.0:23750
EOF

systemctl start docker
systemctl enable docker

echo "Cloning DinD"
git clone https://github.com/jpetazzo/dind.git && cd dind

echo "Building DinD"
docker build -t dind .

echo "Starting DinD"
docker run --privileged -d -p 2375 -e PORT=2375 dind
