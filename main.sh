#!/bin/bash

# Check if domain is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

domain=$1
# chmod +x subdomain_find.sh url_find.sh information.sh detection_engine.sh
./subdomain_find.sh "$domain"
./url_find.sh "$domain"
./information.sh "$domain" 


