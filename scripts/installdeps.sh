#!/bin/bash
set -euo pipefail

echo "🛠️  Updating package lists..."
apt-get update -y

echo "📦 Installing common packages..."
common_packages=(
  libdbus-1-dev
  git-all
  make
  gcc
  docker.io 
  protobuf-compiler 
  build-essential 
  pkg-config 
  curl 
  libssl-dev 
  nodejs
  podman
)

DEBIAN_FRONTEND=noninteractive apt-get install -y "${common_packages[@]}"
echo "✅ Base packages installed successfully."

# Install etcdctl
echo "🔧 Installing etcdctl..."
ETCD_VER=v3.5.11
curl -L "https://github.com/etcd-io/etcd/releases/download/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz" -o etcd.tar.gz
tar xzvf etcd.tar.gz
cp etcd-${ETCD_VER}-linux-amd64/etcdctl /usr/local/bin/
chmod +x /usr/local/bin/etcdctl
echo "✅ etcdctl installed at /usr/local/bin/etcdctl"

# Start etcd with Podman
echo "🚀 Starting etcd container with Podman..."

podman run -it -d -p 2379:2379 -p 2380:2380 --name=piccolo-etcd \
  gcr.io/etcd-development/etcd:v3.5.11 \
  /usr/local/bin/etcd
    echo "✅ etcd container started as 'piccolo-etcd'."
fi

exit 0
