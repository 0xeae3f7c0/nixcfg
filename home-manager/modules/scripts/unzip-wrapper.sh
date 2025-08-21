unzip() {
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    cat <<'EOF'
USAGE:
  unzip all
  unzip <ZIPFILE> [UNZIP OPTIONS]

ARGUMENTS:
  all        Extract every .zip in the current directory into its own folder
  <ZIPFILE>  Specific zip file to extract

OPTIONS:
  Any extra options are passed through to the system 'unzip'

NOTES:
  'unzip all' creates a folder for each .zip named after the archive
EOF
    return
  fi

  # 'unzip all' → extract all .zip files into folders
  if [[ "$1" == "all" ]]; then
    for zipfile in *.zip; do
      [ -e "$zipfile" ] || continue
      foldername=$(basename "$zipfile" .zip)
      echo "Unzipping '$zipfile' into folder: '$foldername'"
      mkdir -p "$foldername"
      command unzip -q "$zipfile" -d "$foldername"
    done

  # otherwise → run normal unzip on given args
  else
    echo "Unzipping individual file: $*"
    command unzip "$@"
  fi
}
