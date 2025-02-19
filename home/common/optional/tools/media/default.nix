{pkgs, ...}: {
  imports = [
    ./imv.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    vlc
    gapless
  ];
}
