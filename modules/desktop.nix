{pkgs, pkgs-unstable, ... }:
let
    # Packages installed system-wide on every desktop
    commonPackages = with pkgs; [
        git
        github-desktop
        libsecret
        pkgs-unstable.vesktop
        vlc
        pkgs-unstable.signal-desktop
        openvpn
        warp-terminal
        gh
        fastfetch
        ];
    in
    {
        environment.systemPackages = commonPackages;

        # KDE Plasma 6
        services.xserver.enable = true;
        services.displayManager.sddm.enable = true;
        services.desktopManager.plasma6.enable = true;

        services.xserver.xkb = {
            layout ="us";
            variant = "";
        };

    # Printing and local network discovery
    services.printing.enable = true;
    services.avahi = {
        enable = true;
        nssmdns4 = true;
        publish = {
            enable = true;
            addresses = true;
            };
        };
    networking.firewall.allowedUDPPorts = [ 5353 ];

    # Apps
    programs.firefox.enable = true;
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
    };
}
