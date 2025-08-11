#!/bin/bash

# Function to perform URL enumeration for a given domain
url_enumeration() {
    local domain=$1
    local date=$(date +'%Y-%m-%d')
    local base_dir="${domain}/$([ "$IGNORE_SPLIT" = "false" ] && echo "${date}/")"
    mkdir -p "${base_dir}"

    waymore -i "${domain}" -mode U -c "${HOME}/config.yml" -oU "${base_dir}/allurls.txt"
    sort -u "${base_dir}/allurls.txt" -o "${base_dir}/allurls.txt"
    
    mkdir -p "${base_dir}/vuln/"
    
    #find endpoints for specific attacks
    tests=(
        "idor"
        "img-traversal"
        "interestingEXT"
        "interestingparams"
        "interestingsubs"
        "lfi"
        "rce"
        "redirect"
        "sqli"
        "ssrf"
        "ssti"
        "xss"
    )
    
    # Loop through each test variable and execute the command
    for test in "${tests[@]}"; do
        echo "Running gf for $test..."
        # Output the result to a file named after the test in the specified vuln subdirectory
        cat "${base_dir}/allurls.txt" | gf $test > "${base_dir}/vuln/$test.txt"
    done
}

# Check if domain is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

# Run the URL enumeration function with the provided domain
url_enumeration "$1"
