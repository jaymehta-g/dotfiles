{config, pkgs, ...}:
let
  nixwfScript = pkgs.writeText "nixwf.xsh" (builtins.readFile ./_nixwf_wrap);
in
{
  home.packages = [
    (pkgs.writeShellScriptBin "nixwf" ''
      export PATH=${pkgs.lib.makeBinPath [ pkgs.nix-output-monitor pkgs.xonsh pkgs.nixfmt-tree ]}:$PATH
      exec ${pkgs.xonsh}/bin/xonsh ${nixwfScript} "$@"
    '')
  ];

}