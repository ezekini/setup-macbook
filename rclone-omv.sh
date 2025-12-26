#!/bin/bash

# --- Configuration ---
SRC="/Volumes/stuff/ELECE"
DST="/Volumes/omv_backup/MAC-backup"


# --- Pre-run Checks ---
if [ ! -d "$SRC" ]; then
    echo "🚨 Error: Source directory '$SRC' not found."
    exit 1
fi

# Define rclone flags. Using a single 'sync' command is the correct way to mirror.
RCLONE_FLAGS=(
    --dry-run
    --progress
    --progress-terminal-title
    --stats-one-line
    --verbose
    --links
    --fast-list
    --delete-excluded 
    --exclude="*.DS_Store"
    --exclude=".Spotlight-V100/**"
    --exclude=".Trashes/**"
    --exclude=".fseventsd/**"
    --exclude=".venv/**"
    --no-update-dir-modtime
)

# --- Main Sync Operation ---
echo "✅ Source drive found."
echo "------------------------------------------------------"
echo "🔄 Starting full mirror sync from '$SRC' to '$DST'..."

# Record the start time
start_time=$(date +%s)

rclone sync "$SRC" "$DST" "${RCLONE_FLAGS[@]}"

end_time=$(date +%s)
duration=$((end_time - start_time))
minutes=$((duration / 60))
seconds=$((duration % 60))

echo "------------------------------------------------------"
echo "🎉 Full sync finished in ${minutes}m ${seconds}s."