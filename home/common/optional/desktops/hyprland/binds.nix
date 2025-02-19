{
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    # ========== Mouse Binds ==========

    bindm = [
      # hold alt + leftlclick  to move/drag active window
      "ALT,mouse:272,movewindow"
      # hold alt + rightclick to resize active window
      "ALT,mouse:273,resizewindow"
    ];

    # ========== Non-consuming Binds ==========

    bindn = [];

    # ========== Repeat Binds ==========
    binde = [
      # ========== Volume Controls ==========

      # Output
      ", XF86AudioRaiseVolume, exec, volumectl -u up "
      ", XF86AudioLowerVolume, exec, volumectl -u down "

      # Input
      "SHIFT, XF86AudioRaiseVolume, exec, volumectl -m -u up "
      "SHIFT, XF86AudioLowerVolume, exec, volumectl -m -u down "

      # ========== Volume Controls ==========

      # Output
      ", XF86MonBrightnessUp, exec, lightctl up"
      ", XF86MonBrightnessDown, exec, lightctl down"
    ];

    # ========== One-shot Binds ==========

    bind = let
      workspaces = [
        "0"
        "1"
        "2"
        "3"
        "4"
        "5"
        "6"
        "7"
        "8"
        "9"
      ];
      # Map keys (arrows and hjkl) to hyprland directions (l, r, u, d)
      directions = rec {
        left = "l";
        right = "r";
        up = "u";
        down = "d";
        h = left;
        l = right;
        k = up;
        j = down;
      };
      terminal = config.home.sessionVariables.TERM;
      editor = config.home.sessionVariables.EDITOR;
      #playerctl = lib.getExe pkgs.playerctl; # installed via /home/common/optional/desktops/playerctl.nix
      #swaylock = "lib.getExe pkgs.swaylock;
      #makoctl = "${config.services.mako.package}/bin/makoctl";
      #gtk-play = "${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play";
      #notify-send = "${pkgs.libnotify}/bin/notify-send";
      #gtk-launch = "${pkgs.gtk3}/bin/gtk-launch";
      #xdg-mime = "${pkgs.xdg-utils}/bin/xdg-mime";
      #defaultApp = type: "${gtk-launch} $(${xdg-mime} query default ${type})";
      #browser = defaultApp "x-scheme-handler/https";
    in
      lib.flatten [
        # ========== Quick Launch ==========

        "SUPER,D,exec,tofi-drun | bash"
        "SUPERSHIFT,D,exec,tofi-run | bash"

        "SUPER,T,exec,${terminal}"
        "SUPER,E,exec,emacsclient -a 'emacs' -c"
        "SUPER,B,exec,librewolf"
        "SUPER,F,exec,nautilus"
        "SUPERSHIFT,F,exec , ${terminal} -e yazi"

        # ========== Screenshotting ==========

        #"SUPER      , P , exec , "
        #"SUPERSHIFT , P , exec , "

        # ========== Media Controls ==========

        # see "binde" above for volume ctrls that need repeat binding
        # Output
        ",XF86AudioMute, exec, volumectl toggle-mute"

        # Input
        ",XF86AudioMicMute, exec, volumectl -m toggle-mute"

        # Player
        ",XF86AudioPlay, exec,playerctl --ignore-player=librewolf play-pause"
        ",XF86AudioNext, exec,playerctl --ignore-player=librewolf next"
        ",XF86AudioPrev, exec,playerctl --ignore-player=librewolf previous"

        # ========== Windows and Groups ==========

        #NOTE: window resizing is under "Repeat Binds" above

        # Close the focused/active window
        "SUPER,Q,killactive"

        # Fullscreen
        "SUPER,G,fullscreen,0" # 0 - fullscreen (takes your entire screen), 1 - maximize (keeps gaps and bar(s))

        # Floating
        "SHIFTALT,G,togglefloating
"
        # Pin Active Floatting window
        "SHIFTALT,p,pin,active" # pins a floating window (i.e. show it on all workspaces)

        # ========== Workspaces ==========

        # Change workspace
        (map (n: "SUPER,${n},workspace,${n}") workspaces)

        # Special/scratch
        "SUPER,0, togglespecialworkspace"
        "SUPERSHIFT,0,movetoworkspace,special"

        # Move window to workspace
        (map (n: "SUPERSHIFT,${n},movetoworkspace,${n}") workspaces)

        # Move focus from active window to window in specified direction
        (lib.mapAttrsToList (key: direction: "SUPER ,${key},movefocus,${direction}") directions)

        # Move windows
        #(lib.mapAttrsToList (key: direction: "SHIFTALT,${key}, exec, customMoveWindow ${direction}") directions)
        (lib.mapAttrsToList (key: direction: "SUPERSHIFT,${key},movewindow,${direction}") directions)

        # ========== Misc ==========

        "SUPERSHIFT,Q,exit"
        "SUPERCTRL,Q,exec,hyprlock" # lock the wm
      ];
  };
}
