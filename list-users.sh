#!/bin/bash

# Test script for Users API endpoint
# Usage: API_KEY=your_key_here ./test-users.sh [BASE_URL]

set -e

# Configuration
BASE_URL="${1:-https://staging.seniorplace.com}"
API_KEY="${API_KEY:-}"

if [ -z "$API_KEY" ]; then
    echo "Error: API_KEY environment variable is required"
    echo "Usage: API_KEY=your_key_here $0 [BASE_URL]"
    exit 1
fi

curl -H "Authorization: ApiKey $API_KEY" \
    -H "Content-Type: application/json" \
    "$BASE_URL/api/v1/users"