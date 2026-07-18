{
  description = "Home Manager configuration of jay";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    timewall.url = "github:bcyran/timewall";
  };

  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # hm will try to pick "user@hostname" and fallback to "user"
      homeConfigurations."jay" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs system;
        };
        modules = [ ./home.nix ];
      };
      homeConfigurations."jay@lenovo" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs system;
        };
        modules = [
          ./home.nix
          ./hosts/lenovo.nix
        ];
      };
    };
}
