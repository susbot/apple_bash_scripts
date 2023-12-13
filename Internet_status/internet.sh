#!/bin/bash

<<comment
The following script has been developed to automate testing of internet connectivity with end users.
This script is authored in Bash and is bundled as an application using Platypus.
You have the flexibility to modify the DNS providers to suit your specific location.
The script is designed to provide different prompts in case of internet connectivity failure.
comment

# https://sveinbjorn.org/platypus

# List of DNS providers to ping (add or remove providers as needed)
dns_providers=("8.8.8.8" "1.1.1.1" "208.67.222.222" "208.67.220.220" "9.9.9.9")

# Number of pings to send for non-Google DNS providers (adjust as needed)
ping_count=5

# Function to perform the ping test and display the result
perform_ping_test() {
  local dns_server="$1"
  local result

  # Check if the DNS provider is Google DNS (8.8.8.8)
  if [ "$dns_server" == "8.8.8.8" ]; then
    result=$(ping -c 1 "$dns_server" 2>&1)
  else
    result=$(ping -c "$ping_count" "$dns_server" 2>&1)
  fi

  if [[ $? -eq 0 ]]; then
    echo "Ping to $dns_server: Success"
  else
    echo "Ping to $dns_server: Failure"
    all_successful=false
  fi
}

# Capture the laptop's DNS address
laptop_dns=$(cat /etc/resolv.conf | grep 'nameserver' | awk '{print $2}')

# Display the laptop's DNS address
echo "Laptop DNS: $laptop_dns"

# Variable to track success
all_successful=true

# Loop through DNS providers and perform ping tests
for dns in "${dns_providers[@]}"; do
  perform_ping_test "$dns"
done

# Perform a single ping test for the laptop's DNS
perform_ping_test "$laptop_dns"
# Display a final message based on the value of all_successful
if [ "$all_successful" = true ]; then
  echo "All tests have been successfully completed."
else
  echo "Some tests have failed, please contact #helpdesk-it."
fi
