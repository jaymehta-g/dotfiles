{pkgs ? import <nixpkgs> {}}:
pkgs.stdenv.mkDerivation {
  name = "reversal-icons";

  src = pkgs.fetchFromGitHub {
    owner = "yeyushengfan258";
    repo = "Reversal-icon-theme";
    rev = "1bdf4c65abb207c0741c76311ee4878b6a2b0a7c";
    hash = "sha256-PsNtEJaaLwJoHnX7kjfXGpQ21Etm0RYxw2OeuCVWC/o=";
  };

  buildInputs = [
    pkgs.gtk3
    pkgs.bash
  ];
  
  postPatch = ''
    sed -e '1s:/usr/bin/env bash:${pkgs.bash}/bin/bash:' -i install.sh
  '';

  installPhase = ''
    sed -i '1d' ./install.sh
    ./install.sh -d $out/share/icons
  '';
}
