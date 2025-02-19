{
  programs.imv = {
    enable = true;
    settings = {
      options = {
        suppress_default_binds = true;
      };
      binds = {
        # Define some key bindings
        q = "quit";

        # Image navigation
        p = "prev";
        n = "next";
        gg = "goto 1";
        "<Shift+G>" = "goto -1";

        # Panning
        j = "pan 0 -50";
        k = "pan 0 50";
        h = "pan 50 0";
        l = "pan -50 0";

        # Zooming
        "<Shift+K>" = "zoom 1";
        "<Shift+J>" = "zoom -1";

        # Rotate Clockwise by 90 degrees
        "<Ctrl+r>" = "rotate by 90";

        # Other commands
        x = "close";
        f = "fullscreen";
        d = "overlay";
        c = "center";
        s = "scaling next";
        "<Shift+S>" = "upscaling next";
        a = "zoom actual";
        r = "reset";

        # Gif playback
        "<period>" = "next_frame";
        "<space>" = "toggle_playing";

        # Slideshow control
        t = "slideshow +1";
        "<Shift+T>" = "slideshow -1";
      };
    };
  };
}
