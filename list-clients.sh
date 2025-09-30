#!/bin/bash

# Test script for Clients API endpoint
# Usage: API_KEY=your_key_here ./list-clients.sh [BASE_URL]
#
# To add query parameters, modify the URL in the script:
#   - Filter by assigned user: ?assignedUserId=UUID
#   - Get unassigned clients: ?assignedUserId=00000000-0000-0000-0000-000000000000
#   - Filter by update time: ?updatedAfter=2024-01-15T14:30:00Z
#   - Combine filters: ?assignedUserId=UUID&updatedAfter=2024-01-15T14:30:00Z

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
    "$BASE_URL/api/v1/clients"