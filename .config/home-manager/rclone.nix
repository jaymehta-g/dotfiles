{config, pkgs, ...}:
{
	systemd.user.services.rclone = {
    	Unit = {
      		Description = "Mount backblaze crypt remote with rclone. Relies on ~/.config/rclone";
      		After = [ "network-online.target" ];
    	};
    	Service = 
		let
			mount = "%h/.mount/backblaze";
		in
		{
      		Type = "notify";
      		ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${mount}";
      		ExecStart = "${pkgs.rclone}/bin/rclone mount --transfers 8 --log-level INFO --buffer-size 32M --vfs-cache-mode full backblaze-crypt:/ ${mount}";
      		ExecStop="/run/wrappers/bin/fusermount -u ${mount}";
    	};
    	Install.WantedBy = [ "default.target" ];
	};

}