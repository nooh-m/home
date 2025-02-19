{ pkgs, inputs, ... }:

{ 
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.persistence."/persist/home" = {
    directories = [
      config.xdg.userDirs.documents = "${config.home.homeDirectory}/documents";
      config.xdg.userDirs.download = "${config.home.homeDirectory}/downloads";
      config.xdg.userDirs.music = "${config.home.homeDirectory}/audio";
      config.xdg.userDirs.pictures = "${config.home.homeDirectory}/images";
      config.xdg.userDirs.videos = "${config.home.homeDirectory}/video";
      config.xdg.userDirs. extraConfig.XDG_PROJECTS_DIR
      ".gnupg"
      ".ssh"
      ".nixops"
      ".local/share/keyrings"
      ".local/share/direnv"
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
    files = [
      ".screenrc"
    ];
    allowOther = true;
  };
}
