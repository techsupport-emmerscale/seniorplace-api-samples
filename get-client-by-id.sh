#!/bin/bash

# Test script for Get Client by ID API endpoint
# Usage: API_KEY=your_key_here ./get-client-by-id.sh CLIENT_ID [BASE_URL]

set -e

# Configuration
CLIENT_ID="${1:-}"
BASE_URL="${2:-https://staging.seniorplace.com}"
API_KEY="${API_KEY:-}"

if [ -z "$API_KEY" ]; then
    echo "Error: API_KEY environment variable is required"
    echo "Usage: API_KEY=your_key_here $0 CLIENT_ID [BASE_URL]"
    exit 1
fi

if [ -z "$CLIENT_ID" ]; then
    echo "Error: CLIENT_ID is required"
    echo "Usage: API_KEY=your_key_here $0 CLIENT_ID [BASE_URL]"
    exit 1
fi

curl -H "Authorization: ApiKey $API_KEY" \
    -H "Content-Type: application/json" \
    "$BASE_URL/api/v1/clients/$CLIENT_ID" | jq '.'