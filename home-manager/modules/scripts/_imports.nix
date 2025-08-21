{
  programs.bash = {
    enable = true;
    initExtra = ''
      ${builtins.readFile ./git-wrapper.sh}
      ${builtins.readFile ./unzip-wrapper.sh}
    '';
  };
}
