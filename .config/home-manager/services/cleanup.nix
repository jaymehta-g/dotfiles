{ config, pkgs, ... }:
{

  # clean up thumbnails and empty trash older than 7 days, on every boot
  systemd.user.services.file-cleanup = {
    Unit.Description = "Delete thumbnails and empty trash older than 7 days";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'rm -rf ~/.cache/thumbnails && ${pkgs.trash-cli}/bin/trash-empty -vf 7'";
    };
    Install.WantedBy = [ "default.target" ];
  };

}
