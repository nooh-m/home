{
  pkgs,
  lib,
  ...
}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [
        "$character"
        "$git_branch"
        "$git_status"
      ];
      right_format = lib.concatStrings [
        "$directory"
        "$cmd_duration"
      ];

      add_newline = false;

      directory = {
        truncation_length = 0;
      };
      character = {
        success_symbol = "[月](bold blue)";
        error_symbol = "[月](bold red)";
      };
      git_branch = {
        format = "[$branch]($style)";
        symbol = "";
        style = "bold #FFA500";
        truncation_symbol = "";
      };
      git_status = {
        format = "[$all_status]($style) ";
        conflicted = " =";
        ahead = " ⇡";
        behind = " ⇣";
        diverged = " ⇕";
        untracked = " ?";
        stashed = " $";
        modified = " !";
        staged = " ⚫";
        renamed = " *";
        deleted = " ✘";
        style = "bold red";
      };
      cmd_duration = {
        min_time = 100;
        format = "[$duration](bold #d1d1d1)";
      };
    };
  };
}
