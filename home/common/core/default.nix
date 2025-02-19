{
  config,
  lib,
  pkgs,
  hostSpec,
  ...
}: {
  imports = [
    ./zsh
    ./git.nix
    ./xdg.nix
  ];

  home = {
    sessionVariables = {
      HOME_FLAKE = "$XDG_PROJECTS_DIR/configs/nix/home";
      SYSTEM_FLAKE = "$XDG_PROJECTS_DIR/configs/nix/system";
      SHELL = "zsh";
      TERM = "ghostty";
      TERMINAL = "ghostty";
      #VISUAL = "emacs";
      #EDITOR = "nvim";
      MANPAGER = "batman";
    };
    preferXdgDirectories = true; # whether to make programs use XDG directories whenever supported
  };
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
