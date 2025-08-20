{ pkgs, inputs, ... }: {
  # Host‑specific packages
  environment.systemPackages = with pkgs; [
    inputs.firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin
  ];
}
