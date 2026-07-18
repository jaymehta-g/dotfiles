{
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.timewall.homeManagerModules.default
  ];

  services.timewall = {
    enable = true;
    wallpaperPath = "/home/jay/Pictures/Wallpapers/wallpaper.heic";
    config = {
      location = {
        lat = 31.3;
        lon = -99.9;
      };
      setter.command = [
        "${pkgs.noctalia-shell}/bin/noctalia-shell"
        "ipc"
        "call"
        "wallpaper"
        "set"
        "%f"
      ];
      setter.quiet = false;
    };
  };
}
