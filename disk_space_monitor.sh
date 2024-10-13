#!/bin/bash
# Script to monitor disk usage and send an email alert if usage exceeds the threshold
# Version: 1.0
# Last updated: Sun Oct 13, 2024

# Set disk partition to monitor (e.g., /dev/sda2)
PARTITION="sda2"


# Set the email recipient for the alert

TO_EMAIL="miss.pangarerevati@gmail.com"


# Get current disk usage percentage for the specified partition

DISK_USAGE=$(df -H | grep "$PARTITION" | awk '{print $5}' | tr -d '%')


# Threshold for triggering the email alert (in percentage)

THRESHOLD=1


# Check if disk usage exceeds the threshold

if [[ $DISK_USAGE -ge $THRESHOLD ]]; then
    # Compose and send an alert email
    (
        echo "To: $TO_EMAIL"
        echo "From: Ubuntu Server <no-reply@server.com>"
        echo "Subject: DISK SPACE ALERT - $PARTITION"
        echo ""
        echo "WARNING: The disk space on partition $PARTITION is critically low."
        echo "Current usage: $DISK_USAGE%."
        echo "Please take immediate action to free up space."
    ) | ssmtp "$TO_EMAIL"

    echo "Disk space alert email sent to $TO_EMAIL - Usage: $DISK_USAGE%."
else
    echo "Disk space is sufficient - $DISK_USAGE% used on $PARTITION."
fi


