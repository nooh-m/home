{
  pkgs,
  config,
  ...
}: let
  myEmacs = pkgs.emacs30-pgtk.override {
    withNativeCompilation = true;
    withTreeSitter = true;
  };
in {
  home.file.emacs = {
    source = ../config/emacs;
    target = "${config.home.homeDirectory}/.config/emacs";
  };
  programs.emacs = {
    enable = true;
    package = myEmacs;
    extraPackages = epkgs:
      with epkgs; [
        vertico
        orderless
        marginalia
        embark
        embark-consult
        consult
        nerd-icons-completion
        nerd-icons-dired
        evil
        evil-collection
        undo-fu
        undo-fu-session
        company
        company-dict
        company-box
        format-all
        cape
        lsp-mode
        treesit-grammars.with-all-grammars
        nix-ts-mode
        doom-modeline
        doom-themes
        dashboard
        general
        nerd-icons-completion
        lsp-ui
        undo-tree
        nyan-mode
        which-key
        undo-tree
        use-package
        yuck-mode
      ];
  };
}
