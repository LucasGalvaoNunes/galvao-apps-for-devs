pidfile="/var/run/docker.pid"
if [ -f "$pidfile" ]; then
    rm -f "$pidfile"
fi

# Use nftables as the backend for iptables
for command in iptables iptables-restore iptables-restore-translate iptables-save iptables-translate
  do
    ln -sf /sbin/xtables-nft-multi /sbin/$command
  done

# Ensure that a bridge exists with the given name
ensure_bridge_exists() {
    name="$1"
    ip_range="$2"

    if ip link show "$name" >/dev/null 2>&1; then
        echo "Bridge '$name' already exists. Skipping creation."
        ip addr show "$name"
        return
    fi

    echo "Bridge '$name' does not exist. Creating..."
    ip link add "$name" type bridge
    ip addr add "$ip_range" dev "$name"
    ip link set "$name" up
    ip addr show "$name"
}

if [ -n "$DOCKER_ENSURE_BRIDGE" ]; then
    bridge="${DOCKER_ENSURE_BRIDGE%%:*}"
    ip_range="${DOCKER_ENSURE_BRIDGE#*:}"
    ensure_bridge_exists "$bridge" "$ip_range"
fi

chmod 666 /data/docker.sock

exec dockerd-entrypoint.sh "$@"