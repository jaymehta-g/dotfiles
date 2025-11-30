{ config, pkgs, ... }:
let
  terminal="alacritty";
  term-run-cmd=terminal + " -e ";
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jay";
  home.homeDirectory = "/home/jay";

  # RICE!
  # home.file.".icons/default".source = "${pkgs.bibata-cursors}share/icons/Bibata-Original-Classic";
  gtk.enable = true;
  gtk.cursorTheme = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 32;
  };
  gtk.gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
  gtk.iconTheme = {
    name = "reversal-icons-orange-dark";
    package = (import ./theming/reversal-icons.nix) {inherit pkgs;};
  };
  # gtk.iconTheme = {
  #   name = "papirus";
  #   package = (pkgs.papirus-icon-theme {color = "orange";});
  # };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.file-roller
  ];

# these go to ~/.local/state/nix/profiles/home-manager/home-path/share/applications
  xdg.desktopEntries = {
    # adofai = {
    #   name = "ADOFAI";
    #   categories = ["Application"];
    #   exec = "steam-run /home/jay/Games/a-dance-of-fire-and-ice-linux/ADanceOfFireAndIce";
    #   icon = "/home/jay/Games/a-dance-of-fire-and-ice-linux/icon.png";
    # };
    "thunar" = {
      name = "Thunar";
      categories = ["FileManager"];
      exec = "thunar";
      icon = "/home/jay/.config/home-manager/file-manager.svg";
    };

    # "thunar-bulk-rename".nodisplay = true;
    # "thunar-settings".nodisplay = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  # find these at
  # /run/current-system/sw/share/applications
  xdg.mimeApps = {
    enable = true;
    defaultApplications = 
    let 
      firefox = "firefox.desktop";
      image = "org.gnome.Loupe.desktop";
      thunderbird = "thunderbird.desktop";
      webMimes = [
        "application/x-pdf" 
        "application/pdf" 
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/chrome"
        "text/html"
        "application/x-extension-htm"
        "application/x-extension-html"
        "application/x-extension-shtml"
        "application/xhtml+xml"
        "application/x-extension-xhtml"
        "application/x-extension-xht"
      ];
    in 
    builtins.listToAttrs (
      map(x: {name=x; value=firefox;}) webMimes
    ) // 
    {
      "inode/directory" = "thunar.desktop";
      "text/plain" = "xed.desktop";

      "image/webp" = image;
      "image/png" = image;
      "image/jpeg" = image;
      "image/gif" = image;

      "message/rfc822" = thunderbird;
      "x-scheme-handler/mid" = thunderbird;
      "x-scheme-handler/feed" = thunderbird;
      "application/rss+xml" = thunderbird;
      "application/x-extension-rss" = thunderbird;
    };
  };

  dconf = {
    settings = 
      {
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
          ];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<Control><Alt>t";
          command = terminal;
          name = "Console";
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
          binding = "<Shift><Super>a";
          command = "normcap";
          name = "OCR";
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
          binding = "<Super>c";
          command = term-run-cmd + " /home/jay/.dotfiles/terminal/utility/nixwf";
          name = "Nix Workflow";
        };
      };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jay/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = 
  {
    TERMINAL = terminal;
    HM = "~/.config/home-manager";
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
}
