{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        # avoid starting multiple hyprlock instances.
        lock_cmd = "pidof hyprlock || hyprlock";

        # lock before suspend.
        before_sleep_cmd = "loginctl lock-session";

        # to avoid having to press a key twice to turn on the display.
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          # 2.5min.
          timeout = 150;

          # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-timeout = "brightnessctl -s set 10";

          # monitor backlight restore.
          on-resume = "brightnessctl -r";
        }

        {
          # 5min
          timeout = 300;

          # lock screen when timeout has passed
          on-timeout = "loginctl lock-session";
        }

        {
          # 5.5min
          timeout = 330;

          # screen off when timeout has passed
          on-timeout = "hyprctl dispatch dpms off";

          # screen on when activity is detected after timeout has fired.
          on-resume = "hyprctl dispatch dpms on";
        }

        {
          # 30min
          timeout = 1800;

          # suspend pc
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
