git() {
  # Help screen
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    cat <<'EOF'
USAGE:
  git pull all [GIT OPTIONS]
  git pull url

ARGUMENTS:
  pull all    Pull latest changes in all git repos in current directory
  pull url    Show remote URLs for all git repos in current directory

OPTIONS:
  Any additional git options are passed through to `git pull`

NOTES:
  For any other commands, defaults to the system 'git'
EOF
    return 0
  fi

  # 'git pull all' → pull latest in all repos in current dir
  if [[ "$1" == "pull" && "$2" == "all" ]]; then
    shift 2
    found=0
    while IFS= read -r -d '' dir; do
      if [[ -d "$dir/.git" ]]; then
        found=1
        echo "Pulling $dir"
        command git -C "$dir" pull "$@"
      fi
    done < <(find . -mindepth 1 -maxdepth 1 -type d -print0)

    (( found == 0 )) && echo "No git repos found in current directory"
    return 0
  fi

  # 'git pull url' → list remote URLs for all repos
  if [[ "$1" == "pull" && "$2" == "url" ]]; then
    shift 2
    found=0
    while IFS= read -r -d '' dir; do
      if [[ -d "$dir/.git" ]]; then
        found=1
        pushd "$dir" >/dev/null || continue
        echo "Remotes in $dir:"
        command git remote -v | awk '{print $2}' | sort -u
        popd >/dev/null || true
      fi
    done < <(find . -mindepth 1 -maxdepth 1 -type d -print0)

    (( found == 0 )) && echo "No git repos found in current directory"
    return 0
  fi

  # fallback → run normal git
  command git "$@"
}
