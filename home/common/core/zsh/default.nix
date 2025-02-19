{
  config,
  pkgs,
  lib,
  ...
}: let
  devDirectory = "~/projects";
  devNix = "${devDirectory}/configs/nix";
in {
  imports = [./starship.nix];
  programs.zsh = {
    enable = true;

    # relative to ~
    dotDir = ".config/zsh";
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    history.size = 10000;
    history.share = true;

    shellAliases = {
      # Overrides those provided by OMZ libs, plugins, and themes.
      # For a full list of active aliases, run `alias`.

      #-------------Bat related------------

      cat = "bat --paging=never";
      diff = "batdiff";
      rg = "batgrep";
      man = "batman";

      #------------Navigation------------

      #l = "eza -lah";
      #la = "eza -lah";
      #ll = "eza -lh";
      #ls = "eza";
      #lsa = "eza -lah";

      #------------Nix src navigation------------

      cnh = "cd ${devNix}/home";
      cns = "cd ${devNix}/system";
      cni = "cd ${devNix}/iso";
      cnp = "cd ${devNix}/pkgs";
      cnm = "cd ${devNix}/modules";

      #-------------Neovim---------------

      #e = "nvim";
      #vi = "nvim";
      #vim = "nvim";
    };
  };
}
