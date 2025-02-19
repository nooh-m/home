{
  config,
  lib,
  pkgs,
  ...
}: let
  wallpapers = pkgs.stdenvNoCC.mkDerivation {
    name = "wallpapers";
    src = ./wallpapers;
    installPhase = ''
      mkdir -p $out/share/wallpapers
      cp -r * $out/share/wallpapers/
    '';
  };
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = ["${wallpapers}/share/wallpapers/yosemite-lowpoly.jpg"];
      wallpaper = ["eDP-1,${wallpapers}/share/wallpapers/yosemite-lowpoly.jpg"];
    };
  };
}
