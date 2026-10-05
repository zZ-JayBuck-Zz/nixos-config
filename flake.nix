{
  description = "NakedSnake's Auto-Updating Stable System Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Add SnOrca Flake
    snapmaker-orca.url = "github:chrstnwhlrt/nix-snapmaker-orca";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, snapmaker-orca, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit pkgs-unstable snapmaker-orca; };
          modules = [ ./configuration.nix ];
        };
      };
    };
}

