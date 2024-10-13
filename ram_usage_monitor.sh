#!/bin/bash
# Script to monitor available RAM space
# Version: 1.0
# Last updated: Sun Oct 13 05:07:01 PM IST 2024


# Fetch available RAM in MB

free_space=$(free -mt | grep "Total" | awk '{print $4}')


# Set threshold for free RAM in MB

THRESHOLD=500


# Check if available RAM is below the threshold

if [[ $free_space -lt $THRESHOLD ]]; then

    	echo "⚠️ WARNING: Available RAM is running low! Only $free_space MB left."
else

    	echo "✅ RAM is sufficient: $free_space MB available."
fi

