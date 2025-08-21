#!/usr/bin/env bash
set -euo pipefail

# Help screen
if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  cat <<'EOF'
USAGE:
  upload <file>
  tar czf - <dir> | upload <name>.tar.gz

ARGUMENTS:
  <file>       Path to a file to upload
  <name>       Name for the uploaded file when piping data (stdin)

NOTES:
  - Uploads to https://temp.sh/upload
  - Files expire after 3 days (max size ~4 GB)
  - Works with direct files or streamed archives
  - In piped mode, the file name is required for the remote end

EXAMPLES:
  upload notes.txt
  tar czf - project | upload project.tar.gz
EOF
  exit 0
fi

if tty -s; then
  # File from disk
  file="$1"
  if [[ ! -f "$file" ]]; then
    echo "Error: '$file' is not a file" >&2
    exit 1
  fi
  curl --progress-bar -F "file=@${file}" https://temp.sh/upload
else
  # Data from stdin
  if [[ $# -lt 1 ]]; then
    echo "Error: name required when piping data" >&2
    exit 1
  fi
  name="$1"
  curl --progress-bar -F "file=@-;filename=${name}" https://temp.sh/upload
fi
