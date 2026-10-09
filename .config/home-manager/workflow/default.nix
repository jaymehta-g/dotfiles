{ config, pkgs, ... }:
let
  nixwfScript = pkgs.writeText "nixwf.xsh" (builtins.readFile ./_nixwf_wrap);
  checkUpstream = pkgs.writeShellScriptBin "check-upstream" (builtins.readFile ./check-upstream.sh);
in
{
  home.packages = [
    checkUpstream
    (pkgs.writeShellScriptBin "nixwf" ''
      export PATH=${
        pkgs.lib.makeBinPath [
          pkgs.nix-output-monitor
          pkgs.xonsh
          pkgs.nixfmt-tree
          pkgs.tmux
          pkgs.libnotify
        ]
      }:$PATH
      tmux new -As nixos_rebuild_workflow "${pkgs.xonsh}/bin/xonsh ${nixwfScript}"
    '')
  ];

  systemd.user.services.check-upstream = {
    Unit = {
      Description = "Check ~/dots and /etc/nixos for unpulled upstream changes and notify";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      Environment = "PATH=${
        pkgs.lib.makeBinPath [
          pkgs.git
          pkgs.libnotify
        ]
      }";
      ExecStart = "${checkUpstream}/bin/check-upstream";
    };
    Install.WantedBy = [ "default.target" ];
  };

  home.file.".scripts/webp2png" = {
    text = ''
      #!/usr/bin/env bash
      for i in "$@"; do ${pkgs.libwebp}/bin/dwebp "$i" -o "''${i%.*}.png"; done
    '';
    executable = true;
  };

  home.file.".scripts/zip2" = {
    text = ''
      #!/usr/bin/env bash
      export PATH=${pkgs.lib.makeBinPath [ pkgs.p7zip ]}:$PATH
      if [[ $# -eq 0 ]]; then
        exit 1
      fi
      dir="$(dirname "$1")"
      base="$(basename "''${1%%/}")"
      out="$dir/$base.zip"
      if [[ -e "$out" ]]; then
        i=1
        while [[ -e "$dir/$base-$i.zip" ]]; do i=$((i+1)); done
        out="$dir/$base-$i.zip"
      fi
      names=()
      for f in "$@"; do
        names+=("$(basename "$f")")
      done
      (cd "$dir" && 7z a -tzip -bso0 -bsp0 "$(basename "$out")" -- "''${names[@]}")
    '';
    executable = true;
  };

  home.file.".scripts/mkv2mp3" = {
    text = ''
      #!/usr/bin/env bash
      for i in "$@"; do ${pkgs.ffmpeg}/bin/ffmpeg -i "$i" -codec copy "''${i%.*}.mp4"; done
    '';
    executable = true;
  };

  home.file.".scripts/pasteimage" = {
    text = ''
      #!/usr/bin/env bash
      export PATH=${pkgs.lib.makeBinPath [ pkgs.wl-clipboard ]}:$PATH
      if [[ $# -ne 1 || ! -d "$1" ]]; then
        exit 1
      fi
      if ! wl-paste -l | grep -qxF 'image/png'; then
        exit 1
      fi
      target="$1/clipboard-$(date +%Y%m%d-%H%M%S).png"
      wl-paste -t image/png > "$target"
    '';
    executable = true;
  };

}
