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

}
