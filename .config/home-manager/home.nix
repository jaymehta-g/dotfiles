{ config, pkgs, ... }:

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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.file-roller
  ];

  xdg.desktopEntries = {
    adofai = {
      name = "ADOFAI";
      categories = ["Application"];
      exec = "steam-run /home/jay/Games/a-dance-of-fire-and-ice-linux/ADanceOfFireAndIce";
      icon = "/home/jay/Games/a-dance-of-fire-and-ice-linux/icon.png";
    };
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
    in 
    {
      "application/pdf" = firefox;
      "application/x-pdf" = firefox;
      "inode/directory" = "nemo.desktop";
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

  # Blackbox in nemo
  dconf = {
    settings = 
      let
        terminal = "exec blackbox";
      in
      {
      "org/cinnamon/desktop/default-applications" = {
        inherit terminal;
      };
      "org/gnome/desktop/default-applications" = {
        inherit terminal;
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
  let
    term="blackbox";
  in
  {
    # EDITOR = "emacs";
    TERMINAL = term;
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
