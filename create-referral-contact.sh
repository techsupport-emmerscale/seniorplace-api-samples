#!/bin/bash

# Script to create a referral contact via API
# Usage: API_KEY=your_key_here ./create-referral-contact.sh "Contact Name" "org-id" [BASE_URL]

set -e

# Configuration
CONTACT_NAME="${1:-}"
ORG_ID="${2:-}"
BASE_URL="${3:-https://staging.seniorplace.com}"
API_KEY="${API_KEY:-}"

if [ -z "$API_KEY" ]; then
    echo "Error: API_KEY environment variable is required"
    echo "Usage: API_KEY=your_key_here $0 \"Contact Name\" \"org-id\" [BASE_URL]"
    exit 1
fi

if [ -z "$CONTACT_NAME" ]; then
    echo "Error: Contact name is required"
    echo "Usage: API_KEY=your_key_here $0 \"Contact Name\" \"org-id\" [BASE_URL]"
    exit 1
fi

if [ -z "$ORG_ID" ]; then
    echo "Error: Organization ID is required"
    echo "Usage: API_KEY=your_key_here $0 \"Contact Name\" \"org-id\" [BASE_URL]"
    exit 1
fi

# Create JSON payload
JSON_DATA=$(cat <<EOF
{
    "name": "$CONTACT_NAME",
    "organizationId": "$ORG_ID"
}
EOF
)

echo "Creating referral contact: $CONTACT_NAME for organization: $ORG_ID"
echo ""

# Make the API request
curl -H "Authorization: ApiKey $API_KEY" \
    -H "Content-Type: application/json" \
    -X POST \
    -d "$JSON_DATA" \
    "$BASE_URL/api/v1/referral-contacts"