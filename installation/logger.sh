#! /bin/bash

set -euo pipefail
source installation/colors.sh

function log_message() {
    local color=""
    local message_type="$1"
    local message="$2"

    case "$message_type" in
        "error")
            color="$RED"
            ;;
        "warning")
            color="$YELLOW"
            ;;
        "info")
            color="$GREEN"
            ;;
        *)
            echo "Unknown message type: $message_type"
            return 1
            ;;
    esac

    echo -e "[${color}${message_type}]${NC} $message"
}