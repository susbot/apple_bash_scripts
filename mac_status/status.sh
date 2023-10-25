#!/bin/bash

# https://sveinbjorn.org/platypus

<<comment When you combine this Bash script with Platypus and deploy it as an application, an end user can manually run this application.
  The script retrieves the serial number and checks the filevault_status of the Apple machine.
  Subsequently, it sends the data to the designated Slack channel using the Slack webhook URL.
comment

# https://sveinbjorn.org/platypus

# Slack webhook URL
slack_webhook_url="Copy and paste slack_webhook_url"

# Function to check if FileVault is enabled
check_filevault_status() {
    local status
    status=$(fdesetup status 2>&1)

    if [[ "$status" == *"FileVault is On"* ]]; then
        echo "FileVault is enabled."
    else
        echo "FileVault is not enabled."
    fi
}

# Get the laptop's serial number
serial_number=$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}')

# Get the currently logged-in user account
user_account=$(whoami)

# Check if FileVault is enabled and include the result
filevault_status=$(check_filevault_status)

# Build the message for Slack
slack_message="Laptop Serial Number: $serial_number\nUser Account: $user_account\nFileVault Status: $filevault_status"

# Send the message to Slack
curl -s -X POST -H 'Content-type: application/json' --data "{'text':'$slack_message'}" "$slack_webhook_url" >/dev/null

# Output a completion message in the terminal
echo "Scan is completed."
