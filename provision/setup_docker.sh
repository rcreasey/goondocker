#!/bin/sh

echo "Installing Docker in base image"
pacman --noconfirm -S docker

cat >/etc/systemd/system/docker.service <<EOF
[Unit]
Description=Docker Application Container Engine
Documentation=http://docs.docker.io
After=network.target

[Service]
ExecStart=/usr/bin/docker -d -H unix:// -H tcp://0.0.0.0:23750 -g /opt/docker
Restart=on-failure
LimitNOFILE=1048576
LimitNPROC=1048576

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start docker
systemctl enable docker

echo "Cloning DinD"
pacman --noconfirm -S git
git clone https://github.com/jpetazzo/dind.git && cd dind

echo "Building DinD"
docker build -t dind .

echo "Starting DinD"
docker run --privileged -d -p 2375:2375 -e PORT=2375 dind
