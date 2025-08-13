{ lib, ... }: {
  programs.bash = {
    enable = true;

    initExtra = lib.strings.concatStringsSep "\n" [
      ''
        git() {
          if [[ "$1" == "pull" && "$2" == "all" ]]; then
            shift 2
            find . -mindepth 1 -maxdepth 1 -type d -print0 |
            while IFS= read -r -d $'\0' dir; do
              if [[ -d "$dir/.git" ]]; then
                echo "Pulling $dir"
                command git -C "$dir" pull "$@"
              fi
            done
            return
          elif [[ "$1" == "pull" && "$2" == "url" ]]; then
            shift 2
            find . -mindepth 1 -maxdepth 1 -type d -print0 |
            while IFS= read -r -d $'\0' dir; do
              if [[ -d "$dir/.git" ]]; then
                pushd "$dir" >/dev/null || continue
                echo "Remotes in $dir:"
                command git remote -v | awk '{print $2}' | sort -u
                popd >/dev/null || true
              fi
            done
            return
          fi

          command git "$@"
        }
      ''
    ];
  };
}
