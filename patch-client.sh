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

read -p "Client name: " CLIENT_NAME
read -p "Email: " EMAIL
read -p "Phone number: " PHONE_NUMBER
read -p "Montly budget: " BUDGET

JSON_DATA=$(jq -n \
    --arg name "$CLIENT_NAME" \
    --arg email "$EMAIL" \
    --arg phone "$PHONE_NUMBER" \
    --arg budget "$BUDGET" \
    '{
        name: $name,
        email: $email,
        phone: $phone,
        budget: $budget
    }'
)

curl -s -H "Authorization: ApiKey $API_KEY" \
    -H "Content-Type: application/json" \
    -X PATCH \
    -d "$JSON_DATA" \
    "$BASE_URL/api/v1/clients/$CLIENT_ID" | jq '.'