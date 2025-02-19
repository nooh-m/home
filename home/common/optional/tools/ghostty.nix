{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.ghostty;
    settings = {
      theme = "tokyonight_night";
      font-family = "SF Mono";
      font-size = 16;

      cursor-style = "block";
      cursor-style-blink = true;
      cursor-invert-fg-bg = true;

      mouse-hide-while-typing = true;

      confirm-close-surface = false;
      window-decoration = false;
      window-padding-x = 10;
      window-padding-y = 10;
      window-padding-balance = true;

      # extras
      shell-integration-features = "no-cursor";
    };
  };
}
