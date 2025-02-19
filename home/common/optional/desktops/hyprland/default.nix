{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./binds.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hypridle.nix
  ];
  home.packages = [inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # ========== Environment Vars ==========

      env = [
        "NIXOS_OZONE_WL, 1" # for ozone-based and electron apps to run on wayland
        "MOZ_ENABLE_WAYLAND, 1" # for firefox to run on wayland
        "MOZ_WEBRENDER, 1" # for firefox to run on wayland
        "XDG_SESSION_TYPE,wayland"
        "WLR_NO_HARDWARE_CURSORS,1"
        "WLR_RENDERER_ALLOW_SOFTWARE,1"
        "QT_QPA_PLATFORM,wayland"
        "HYPRCURSOR_THEME,rose-pine-hyprcursor" # this will be better than default for now
      ];

      # ========== Monitor ==========

      # parse the monitor spec defined in nix-config/home/<user>/<host>.nix
      monitor = "eDP-1, 1920x1080@60, 0x0, 1";

      # ========== Behavior ==========

      binds = {
        workspace_center_on = 1; # Whether switching workspaces should center the cursor on the workspace (0) or on the last active window for that workspace (1)
        movefocus_cycles_fullscreen = false; # If enabled, when on a fullscreen window, movefocus will cycle fullscreen, if not, it will move the focus in a direction.
      };

      input = {
        follow_mouse = 2;
        # follow_mouse options:
        # 0 - Cursor movement will not change focus.
        # 1 - Cursor movement will always change focus to the window under the cursor.
        # 2 - Cursor focus will be detached from keyboard focus. Clicking on a window will move keyboard focus to that window.
        # 3 - Cursor focus will be completely separate from keyboard focus. Clicking on a window will not change keyboard focus.
        mouse_refocus = false;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_create_new = true;
        workspace_swipe_direction_lock = true;
        workspace_swipe_direction_lock_threshold = 10;
        workspace_swipe_distance = 300;
        workspace_swipe_fingers = 3;
        workspace_swipe_forever = false;
        workspace_swipe_invert = false;
        workspace_swipe_min_speed_to_force = 30;
        workspace_swipe_use_r = false;
      };

      misc = {
        disable_hyprland_logo = true;
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        #disable_autoreload = true;
        new_window_takes_over_fullscreen = 1; # 0 - behind, 1 - takes over, 2 - unfullscreen/unmaxize
        middle_click_paste = false;
        allow_session_lock_restore = false;
        always_follow_on_dnd = true;
        close_special_on_empty = true;
        disable_splash_rendering = true;
        enable_swallow = true;
        focus_on_activate = false;
        key_press_enables_dpms = false;
        layers_hog_keyboard_focus = true;
        mouse_move_enables_dpms = false;
        mouse_move_focuses_monitor = true;
        render_ahead_of_time = false;
        render_ahead_safezone = 1;
      };

      #
      # ========== Appearance ==========
      #
      #FIXME-rice colors conflict with stylix
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        resize_on_border = true;
        hover_icon_on_border = true;
        allow_tearing = false; # used to reduce latency and/or jitter in games
        no_border_on_floating = false;
        layout = "master";
      };
      animations = {
        bezier = [
          "easeInOutQuint,0.83,0,0.17,1"
          "easeInQuint,0.64,0,0.78,0"
          "easeOutQuint,0.22,1,0.36,1"
        ];
        animation = [
          "windowsIn,1,3,easeInQuint,popin"
          "windowsOut,1,3,easeOutQuint,popin"
          "windowsMove,1,3,easeInOutQuint,popin"
          "fadeIn,1,3,easeInQuint"
          "fadeOut,1,3,easeOutQuint"
          "fadeSwitch,1,3,easeInOutQuint"
          "fadeShadow,1,3,easeInOutQuint"
          "fadeDim,1,3,easeInOutQuint"
          "border,0,3,easeInOutQuint"
          "borderangle,0,3,easeInOutQuint"
          "workspaces,1,3,easeInQuint,fade"
        ];
        enabled = true;
      };

      decoration = {
        active_opacity = 1.0;
        inactive_opacity = 0.85;
        fullscreen_opacity = 1.0;
        rounding = 10;
        dim_inactive = true;
        dim_strength = 0.07;
        dim_special = 0.5;
        blur = {
          enabled = true;
          size = 5;
          passes = 1;
          new_optimizations = true;
          popups = true;
        };
        shadow = {
          enabled = true;
          range = 12;
          offset = "3 3";
        };
      };

      # ========== Auto Launch ==========

      exec-once = [
        "hyprpaper"
        "avizo-server"
      ];

      # ========== Layer Rules ==========

      layer = [
        #"blur, rofi"
        #"ignorezero, rofi"
        #"ignorezero, logout_dialog"
      ];

      # ========== Window Rules ==========

      windowrule = [
        # Dialogs
        "float, title:^(Open File)(.*)$"
        "float, title:^(Select a File)(.*)$"
        "float, title:^(Choose wallpaper)(.*)$"
        "float, title:^(Open Folder)(.*)$"
        "float, title:^(Save As)(.*)$"
        "float, title:^(Library)(.*)$"
        "float, title:^(Accounts)(.*)$"
      ];
      windowrulev2 = [
        "float, class:^(galculator)$"
        "float, class:^(waypaper)$"
        "float, class:^(keymapp)$"

        #
        # ========== Always opaque ==========
        #
        "opaque, class:^([Gg]imp)$"
        "opaque, class:^([Ff]lameshot)$"
        "opaque, class:^([Ii]nkscape)$"
        "opaque, class:^([Bb]lender)$"
        "opaque, class:^([Oo][Bb][Ss])$"
        "opaque, class:^([Ss]team)$"
        "opaque, class:^([Ss]team_app_*)$"
        "opaque, class:^([Vv]lc)$"

        # Remove transparency from video
        "opaque, title:^(Netflix)(.*)$"
        "opaque, title:^(.*YouTube.*)$"
        "opaque, title:^(Picture-in-Picture)$"

        # ========== Fameshot rules ==========

        # flameshot currently doet have great wayland support so needs some tweaks
        #"rounding 0, class:^([Ff]lameshot)$"
        #"noborder, class:^([Ff]lameshot)$"
        #"float, class:^([Ff]lameshot)$"
        #"move 0 0, class:^([Ff]lameshot)$"
        #"suppressevent fullscreen, class:^([Ff]lameshot)$"
        # "monitor:DP-1, ${flameshot}"

        #
        # ========== Workspace Assignments ==========
        #
        "workspace 3, class:^(librewolf)$"
        "workspace 1, class:^(*[Ee]macs*)$"
        "workspace 2, class:^(*[Gg]ohstty*)$"
        "workspace special, title:^([Ss]potify*)$"
      ];
    };
  };
}
