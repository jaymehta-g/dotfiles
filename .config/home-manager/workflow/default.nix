{ config, pkgs, ... }:
let
  nixwfScript = pkgs.writeText "nixwf.xsh" (builtins.readFile ./_nixwf_wrap);
in
{
  home.packages = [
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

  home.file.".scripts/webp2png" = {
    text = ''
      #!/usr/bin/env bash
      for i in "$@"; do ${pkgs.libwebp}/bin/dwebp "$i" -o "''${i%.*}.png"; done
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

  home.file.".scripts/pi-sandbox" = {
    text = ''
            #!/usr/bin/env bash
            ${pkgs.bubblewrap}/bin/bwrap \
              --ro-bind / / \
              --bind "$PWD" "$PWD" \
              --dev /dev \
              --proc /proc \
              --bind /tmp /tmp \
              --bind /nix /nix \
              --bind ~/.cache ~/.cache \
              --bind ~/.local ~/.local \
      	      --bind ~/.pi/agent ~/.pi/agent \
      	      --tmpfs /run \
              --ro-bind /run/current-system /run/current-system \
              -- pi $@
    '';
    executable = true;
  };

}
