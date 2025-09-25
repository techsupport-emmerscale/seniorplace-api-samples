#!/bin/bash

# Script to create a client via API with intelligent defaults
# Usage: API_KEY=your_key_here ./create-client.sh [BASE_URL]

set -e

BASE_URL="${1:-https://staging.seniorplace.com}"
API_KEY="${API_KEY:-}"

# Check for required dependencies
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required. Install with: brew install jq"
    exit 1
fi

if [ -z "$API_KEY" ]; then
    echo "Error: API_KEY environment variable is required"
    exit 1
fi

# Fetch required data
REFERRAL_CONTACTS=$(curl -s -H "Authorization: ApiKey $API_KEY" "$BASE_URL/api/v1/referral-contacts")
USERS=$(curl -s -H "Authorization: ApiKey $API_KEY" "$BASE_URL/api/v1/users")
CLIENT_STATUSES=$(curl -s -H "Authorization: ApiKey $API_KEY" "$BASE_URL/api/v1/client-statuses")

# Parse the fetched data
ASSIGNED_USER_ID=$(echo "$USERS" | jq -r '.[0].id // empty')
REFERRAL_CONTACT_ID=$(echo "$REFERRAL_CONTACTS" | jq -r '.[0].id // empty')
REFERRAL_ORG_ID=$(echo "$REFERRAL_CONTACTS" | jq -r '.[0].organizationId // empty')
STATUS_ID=$(echo "$CLIENT_STATUSES" | jq -r '[.[] | select(.isArchived != true)][0].id // empty')

# Get client name
read -p "Client name: " CLIENT_NAME
read -p "Best contact name (optional): " BEST_CONTACT_NAME

# Build contacts array
CONTACTS="[]"
if [ -n "$BEST_CONTACT_NAME" ]; then
    CONTACTS=$(jq -n --arg name "$BEST_CONTACT_NAME" '[{name: $name, relationship: "Other", isPrimary: true}]')
fi

# Build the complete JSON payload
JSON_DATA=$(jq -n \
    --arg statusId "$STATUS_ID" \
    --arg name "$CLIENT_NAME" \
    --arg assignedUserId "$ASSIGNED_USER_ID" \
    --arg referralContactId "$REFERRAL_CONTACT_ID" \
    --arg referralOrganizationId "$REFERRAL_ORG_ID" \
    --argjson contacts "$CONTACTS" \
    '{
        statusId: $statusId,
        name: $name,
        customFields: [
            {key: "Question_CommunityTypes", value: ["Option_MemoryCare"]},
            {key: "Question_Activities", value: true},
            {key: "Question_Hobbies", value: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"}
        ]
    } +
    (if $assignedUserId != "" then {assignedUserId: $assignedUserId} else {} end) +
    (if $referralContactId != "" then {referralContactId: $referralContactId} else {} end) +
    (if $referralOrganizationId != "" then {referralOrganizationId: $referralOrganizationId} else {} end) +
    (if ($contacts | length) > 0 then {contacts: $contacts} else {} end)')

# Pretty-print the request payload to stderr for debugging
echo "Request payload:" >&2
echo "$JSON_DATA" | jq '.' >&2

# Make the API request and show result
curl -s -H "Authorization: ApiKey $API_KEY" \
    -H "Content-Type: application/json" \
    -X POST \
    -d "$JSON_DATA" \
    "$BASE_URL/api/v1/clients" | jq '.'