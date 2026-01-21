#!/bin/bash
# Stitch MCP Token Refresh Script
# Regenerates the gcloud access token for Stitch MCP

set -e

# Check if gcloud is installed
if ! command -v gcloud &> /dev/null; then
    echo "Error: gcloud CLI not found. Install with: brew install google-cloud-sdk"
    exit 1
fi

# Check if authenticated
if ! gcloud auth application-default print-access-token &> /dev/null; then
    echo "Error: Not authenticated. Run: gcloud auth application-default login"
    exit 1
fi

# Generate new token
TOKEN=$(gcloud auth application-default print-access-token)

echo "New access token generated."
echo ""
echo "To use in current shell:"
echo "  export STITCH_ACCESS_TOKEN='$TOKEN'"
echo ""
echo "Or add to your shell config (~/.zshrc):"
echo "  export STITCH_ACCESS_TOKEN=\$(gcloud auth application-default print-access-token)"
echo ""

# Optionally export directly
if [ "$1" = "--export" ]; then
    echo "export STITCH_ACCESS_TOKEN='$TOKEN'"
fi
