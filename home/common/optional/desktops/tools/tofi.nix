{pkgs, ...}: {
  programs.tofi = {
    enable = true;
    settings = {
      font = "SF Pro";
      font-size = 14;
      font-features = "";
      font-variations = "";
      hint-font = true;

      # Window Style;
      horizontal = true;
      anchor = "top";
      width = "100%";
      height = 38;

      outline-width = 0;
      border-width = 0;
      min-input-width = 120;
      result-spacing = 30;
      padding-top = 8;
      padding-bottom = 0;
      padding-left = 20;
      padding-right = 0;

      # Text style;
      prompt-text = "Can I have a";
      prompt-padding = 30;

      background-color = "#1a1b26";
      text-color = "#a9b1d6";

      prompt-background = "#cfc9c2";
      prompt-color = "#1a1b26";
      prompt-background-padding = "4, 10";
      prompt-background-corner-radius = 10;

      input-color = "#e0af68";
      input-background = "#1a1b26";
      input-background-padding = "4, 10";
      input-background-corner-radius = 10;

      alternate-result-background = "#c0caf5";
      alternate-result-color = "#1a1b26";
      alternate-result-background-padding = "4, 10";
      alternate-result-background-corner-radius = 12;

      selection-color = "#f0d2af";
      selection-background = "#da5d64";
      selection-background-padding = "4, 10";
      selection-background-corner-radius = 12;
      selection-match-color = "#fff";

      clip-to-padding = false;
    };
  };
}
