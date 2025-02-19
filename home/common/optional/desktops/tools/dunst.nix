{
  # Enable Dunst
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        geometry = "300x60-15+46";
        indicate_hidden = "yes";
        shrink = "yes";
        transparency = 0;
        notification_height = 0;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        frame_width = 3;
        frame_color = "#000000";
        separator_color = "frame";
        sort = "yes";
        idle_threshold = 120;
        font = "Museo Sans 10";
        line_height = 0;
        markup = "full";
        format = "<b>%s</b> %b";
        alignment = "left";
        show_age_threshold = 60;
        word_wrap = "yes";
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = "true";
        hide_duplicate_count = "false";
        show_indicators = "yes";
        icon_position = "left";
        max_icon_size = 42;
        sticky_history = "yes";
        history_length = 20;
        #dmenu = "rofi -p dunst:";
        browser = "firefox -new-tab";
        always_run_script = "true";
        title = "Dunst";
        class = "Dunst";
        startup_notification = "false";
        verbosity = "mesg";
        corner_radius = 8;
        force_xinerama = "false";
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action";
        mouse_right_click = "close_all";
      };
      urgency_low = {
        foreground = "#a9b1d6";
        background = "#1a1b26";
        frame_color = "#0db9d7";
        timeout = 10;
      };
      urgency_normal = {
        background = "#1a1b26";
        foreground = "#a9b1d6";
        frame_color = "#0db9d7";
        timeout = 10;
      };
      urgency_critical = {
        background = "#1a1b26";
        foreground = "#a9b1d6";
        frame_color = "#0db9d7";
        timeout = 0;
      };
    };
  };
}
