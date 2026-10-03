{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true; # needed for Steam and other unfree pkgs
      };
    in {
      # Expose some useful packages (including Steam) as flake outputs
      packages.${system} = {
        # individual packages
        steam = pkgs.steam;
        git = pkgs.git;
        github-desktop = pkgs.github-desktop;
        libsecret = pkgs.libsecret;
        vesktop = pkgs.vesktop;
        vlc = pkgs.vlc;
        orca-slicer = pkgs.orca-slicer;
        signal-desktop = pkgs.signal-desktop;
        openvpn = pkgs.openvpn;

        # an aggregate package roughly mirroring your systemPackages
        default = pkgs.buildEnv {
          name = "system-packages";
          paths = with pkgs; [
            git
            github-desktop
            libsecret
            vesktop
            vlc
            orca-slicer
            signal-desktop
            openvpn
            steam
          ];
        };
      };

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          { nix.settings.experimental-features = [ "nix-command" "flakes" ]; }
          ./configuration.nix
        ];
      };
    };
}
