#! /bin/bash

set -euo pipefail
source installers/logger.sh

function diff_files() {
  origin=$1
  destination=$2
  if ! diff -r "$origin" "$destination" >/dev/null ; then
    log_message "warning" "Differences between $origin and $destination! Rsync will perform a backup of the local (destination) file."
fi
}
