#!/bin/bash

# Test script for Client Statuses API endpoint
# Usage: API_KEY=your_key_here ./test-client-statuses.sh [BASE_URL]

set -e

# Configuration
BASE_URL="${1:-http://localhost:3000}"
API_KEY="${API_KEY:-}"

if [ -z "$API_KEY" ]; then
    echo "Error: API_KEY environment variable is required"
    echo "Usage: API_KEY=your_key_here $0 [BASE_URL]"
    exit 1
fi

curl -H "Authorization: ApiKey $API_KEY" \
    -H "Content-Type: application/json" \
    "https://staging.seniorplace.com/api/v1/client-statuses"
