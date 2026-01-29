#!/usr/bin/env bash

set -euo pipefail

INTERFACE="${1:-enp0s3}"
#Uses first arg to check interface, default enp0s3

TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
#Timestamp to create unique filenames

OUTPUT="${HOME}/logs/ipv6snapshot_${INTERFACE}_${TIMESTAMP}.txt"


{
    echo "=== IPv6 Snapshot ==="
    echo "Host: $(hostname)"
    echo "Time: $(date -Is)"
    echo "Interface: ${INTERFACE}"
    echo


    echo "--- ip -6 addr show dev ${INTERFACE} ---"
    ip -6 addr show dev "${INTERFACE}"
    echo

    echo "--- ip -6 route ---"
    ip -6 route
    echo

    echo "--- ip -6 neigh show dev ${INTERFACE} ---"
    ip -6 neigh show dev "${INTERFACE}"
    echo
} > "${OUTPUT}"
#Writes output to snapshot file.
echo
echo "Saved log file to: ${OUTPUT}"
echo "================="
read -n 1 -s -r -p "Press any key to exit."
echo
echo