{pkgs, ...}: let
  rose-pine-icons = pkgs.stdenv.mkDerivation {
    name = "rosepine-icons";

    src = pkgs.fetchFromGitHub {
      owner = "Fausto-Korpsvart";
      repo = "Rose-Pine-GTK-Theme";
      rev = "main";
      sha256 = "sha256-nEp9qHVfGMzO6QqkYk1NJ5FT+h0m/bnkrJUzAskNUac=";
    };

    dontUnpack = true;

    configurePhase = "";
    buildPhase = "";
    patchPhase = "";
    installPhase = ''
      mkdir -p $out/share/icons
      cp -r $src/icons/* $out/share/icons
    '';
  };
in {
  gtk = {
    enable = true;

    theme = {
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };

    iconTheme = {
      name = "Rose-Pine";
      package = rose-pine-icons;
    };

    cursorTheme = {
      name = "BreezeX-RosePine-Linux";
      package = pkgs.rose-pine-cursor;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}
