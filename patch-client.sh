#!/bin/bash

# Script to update a client via API
# Usage: API_KEY=your_key_here ./patch-client.sh CLIENT_ID [BASE_URL]

set -e

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

echo "Updating client $CLIENT_ID with sample data..."
echo ""

curl -s -H "Authorization: ApiKey $API_KEY" \
    -H "Content-Type: application/json" \
    -X PATCH \
    -d '{
        "name": "Updated Client Name",
        "email": "updated@example.com",
        "phone": "(555) 999-8888",
        "monthlyBudget": 5500
    }' \
    "$BASE_URL/api/v1/clients/$CLIENT_ID" | jq '.'