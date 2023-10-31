#!/bin/bash

'
The following script has been developed to automate testing of internet connectivity with end users.
This script is authored in Bash and is bundled as an application using Platypus.
You have the flexibility to modify the DNS providers to suit your specific location.
The script is designed to provide different prompts in case of internet connectivity failure.
This is version 1.1, added additional dns providers, changed the output to funny phrases.
'

dns_providers=("8.8.8.8" "8.8.4.4" "1.1.1.1" "1.0.0.1" "208.67.222.222" "208.67.220.220")

phrases=("Almost at the finish line" "Just a bit more to go" "Few more steps to success" "Almost within reach" "Just a heartbeat away from success" "The finish line is in sight" "Just around the corner")

funny_failure_phrases=("Seems like I've hit a little snag" "Well, isn't that a pickle" "Houston, we have a problem" "That wasn't on the agenda" "A little hiccup on the way" "Aw, shucks!")

echo "Pinging the top DNS providers three times each:"
echo "---------------------------------------"

failed_providers=()

for ((i=0; i<${#dns_providers[@]}; i++)); do
    provider="${dns_providers[i]}"
    phrase="${phrases[i]}"
    failure_phrase="${funny_failure_phrases[i]}"

    # Ping the provider one time and suppress both stdout and stderr
    if ping -c 3 "$provider" > /dev/null 2>&1; then
        echo "$phrase"
    else
        failed_providers+=("$provider")
        echo "$failure_phrase - Ping to $provider failed. Stopping further pings."
        break
    fi
done

echo "---------------------------------------"
echo "Testing completed."

if [ ${#failed_providers[@]} -gt 0 ]; then
    echo "Please contact the #helpdesk-it channel or your local IT representative."
else
    echo "All pings were successful! You have internet connectivity."
fi
