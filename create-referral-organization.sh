#!/bin/bash

# Script to create a referral organization via API
# Usage: API_KEY=your_key_here ./create-referral-organization.sh "Organization Name" [BASE_URL]

set -e

# Configuration
ORG_NAME="${1:-}"
BASE_URL="${2:-https://staging.seniorplace.com}"
API_KEY="${API_KEY:-}"

if [ -z "$API_KEY" ]; then
    echo "Error: API_KEY environment variable is required"
    echo "Usage: API_KEY=your_key_here $0 \"Organization Name\" [BASE_URL]"
    exit 1
fi

if [ -z "$ORG_NAME" ]; then
    echo "Error: Organization name is required"
    echo "Usage: API_KEY=your_key_here $0 \"Organization Name\" [BASE_URL]"
    exit 1
fi

# Create JSON payload
JSON_DATA=$(cat <<EOF
{
    "name": "$ORG_NAME"
}
EOF
)

echo "Creating referral organization: $ORG_NAME"
echo ""

# Make the API request
curl -H "Authorization: ApiKey $API_KEY" \
    -H "Content-Type: application/json" \
    -X POST \
    -d "$JSON_DATA" \
    "$BASE_URL/api/v1/referral-organizations"