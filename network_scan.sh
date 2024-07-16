#!/bin/bash


NETWORK="ip"
TARGET_FILE="active_targets.txt"

echo "Scanning network $NETWORK for active hosts..."
nmap -sn $NETWORK -oG - | awk '/Up$/{print $2}' > $TARGET_FILE

echo "Active hosts have been saved to $TARGET_FILE"
