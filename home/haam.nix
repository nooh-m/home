{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    ./common/core
    ./common/optional/tools
    #./common/optional/browsers
    ./common/optional/desktops
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [];

    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "haam";
    homeDirectory = "/home/haam";
    stateVersion = "24.11";
    packages = [pkgs.librewolf];
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
