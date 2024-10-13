#!/bin/bash

# Script to send an email using ssmtp
# Version: 1.0
# Last updated: Sun Oct 13, 2024

# Email recipient, subject, and sender details
TO="your-email@example.com"
SUBJECT="Test Email"
FROM="your-email@example.com"  # Replace with the actual sender's email if needed

# Define the email body or path to email content file (email.txt)
EMAIL_BODY="email.txt"

# Check if the email body file exists
if [[ ! -f $EMAIL_BODY ]]; then
    echo "Error: Email body file ($EMAIL_BODY) does not exist."
    exit 1
fi

# Send the email using ssmtp
echo "Sending email to $TO with subject '$SUBJECT'..."

ssmtp "$TO" < "$EMAIL_BODY" || { echo "Failed to send the email."; exit 1; }

echo "Email sent successfully to $TO with subject '$SUBJECT'."

