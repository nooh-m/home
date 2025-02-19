{
  pkgs,
  inputs,
  ...
}: {
  programs.eww = {
    enable = true;
    enableZshIntegration = true;
    configDir = ../../config/eww;
  };
}
