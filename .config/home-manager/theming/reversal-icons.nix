{pkgs ? import <nixpkgs> {}}:
let 
  args = "-orange";
in 
pkgs.stdenv.mkDerivation {
  name = "reversal-icons";

  src = pkgs.fetchFromGitHub {
    owner = "yeyushengfan258";
    repo = "Reversal-icon-theme";
    rev = "bdae2ea365731b25a869fc2c8c6a1fb849eaf5b2";
    hash = "sha256-Cd+1ggyS+Y2Sk8w5zifc4IFOwbFrbjL6S6awES/W0EE=";
  };

  buildInputs = [
    pkgs.gtk3
  ];

  postPatch = ''
    sed -e '1s:/bin/bash:${pkgs.bash}/bin/bash:' -i install.sh
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons
    # rm -r ./src/status
    ./install.sh ${args} -d $out/share/icons
    runHook postInstall
  '';
}