#!/bin/bash

TARGET_FILE="active_targets.txt"

if [ ! -f "$TARGET_FILE" ]; then
    echo "Target file $TARGET_FILE not found! Please run the network scan first."
    exit 1
fi

while IFS= read -r TARGET; do
    if [ -n "$TARGET" ]; then
        OUTPUT_FILE="smb_enum_results_$TARGET.txt"

        echo "Scanning SMB versions on $TARGET..."
        nmap -p 139,445 --script smb-protocols $TARGET > $OUTPUT_FILE

        echo "Enumerating SMB shares on $TARGET..."
        nmap -p 139,445 --script smb-enum-shares $TARGET >> $OUTPUT_FILE

        echo "Checking for password protected shares..."
        smbclient -L //$TARGET -N >> $OUTPUT_FILE

        echo "Results for $TARGET have been saved to $OUTPUT_FILE"
    fi
done < "$TARGET_FILE"
