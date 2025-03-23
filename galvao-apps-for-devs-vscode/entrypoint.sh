#!/bin/sh

ensure_bridge_exists() {
  local bridge="$1"
  local ip_range="$2"

  if ! ip link show "$bridge" >/dev/null 2>&1; then
    echo "Criando bridge $bridge com IP $ip_range"
    ip link add "$bridge" type bridge
    ip addr add "$ip_range" dev "$bridge"
    ip link set "$bridge" up
  else
    echo "Bridge $bridge já existe."
  fi
}

if [ -n "$DOCKER_ENSURE_BRIDGE" ]; then
  bridge="${DOCKER_ENSURE_BRIDGE%%:*}"
  ip_range="${DOCKER_ENSURE_BRIDGE#*:}"
  ensure_bridge_exists "$bridge" "$ip_range"
fi

exec "$@"