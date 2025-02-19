{
  config,
  pkgs,
  ...
}: let
  homeDir = config.home.homeDirectory;
in {
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    policies = {
      AppAutoUpdate = false; # Disable automatic application update
      BackgroundAppUpdate = false; # Disable automatic application update in the background, when the application is not running.
      DefaultDownloadDirectory = "${config.xdg.userDirs.download}";
      DisableBuiltinPDFViewer = true;
      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = false; # Enable Firefox Sync
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      OfferToSaveLogins = false; # Managed by Proton
      "webgl.disabled" = false; # See [1], WebGL is nice
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cache" = false;
      "privacy.clearOnShutdown.downloads" = false;
      "privacy.clearOnShutdown.cookies" = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
        # Exceptions = ["https://example.com"]
      };
      ExtensionUpdate = false;

      ExtensionSettings = (
        let
          extension = shortId: uuid: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = "normal_installed";
            };
          };
        in
          builtins.listToAttrs [
            #TODO Add more of these and test. not high priority though since mozilla sync will pull them in too
            # Development
            #(extension "user-agent-switcher" "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}") # failed

            # Privacy / Security
            (extension "noscript" "{73a6fe31-595d-460b-a920-fcc0f8843232}")
            (extension "ublock-origin" "uBlock0@raymondhill.net")
            (extension "ignore-cookies" "jid1-KKzOGWgsW3Ao4Q@jetpack") # failed # Ignore cookie setting pop-ups
            (extension "proton-pass" "78272b6fa58f4a1abaac99321d503a20@proton.me")
            (extension "proton-vpn-firefox-extension" "vpn@proton.ch") # failed
            (extension "privacy-badger17" "jid1-MnnxcxisBPnSXQ@jetpack")
            (extension "cookie-autodelete" "CookieAutoDelete@kennydo.com")

            # Layout / Themeing
            (extension "tree-style-tab" "treestyletab@piro.sakura.ne.jp")
            (extension "darkreader" "addon@darkreader.org")

            # Voice
            (extension "domain-in-title" "{966515fa-4c81-4afe-9879-9bbaf8576390}")
            #(extension "rango" "rango@david-tejada")

            # Misc
            (extension "s3download-statusbar" "{6913849f-c79f-4f3e-83e4-890d91ad6154}")
            (extension "auto-tab-discard" "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}")
            (extension "reddit-enhancement-suite" "jid1-xUfzOsOFlzSOXg@jetpack")
          ]
      );
    };

    profiles = {
      "${config.home.username}" = {
        name = "${config.home.username}";
        isDefault = true;
        search = {
          default = "google";
          engines = {
            "Nix Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "type";
                      value = "options";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@no"];
            };
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };

            "NixOS Wiki" = {
              urls = [
                {
                  template = "https://nixos.wiki/index.php?search={searchTerms}";
                }
              ];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@nw"];
            };

            "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          };
          order = ["DuckDuckGo" "Google"];
        };
        userChrome = builtins.readFile ../config/firefox/userChrome;
        userContent = builtins.readFile ../config/firefox/userContent;
      };
    };
  };
}
