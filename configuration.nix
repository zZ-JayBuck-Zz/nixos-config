# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-unstable, snapmaker-orca, ... }:

let
  # Packages you want both system-wide and for your user
  commonPackages = with pkgs; [
    git
    github-desktop
    libsecret
    pkgs-unstable.vesktop #Rolling latest
    vlc
    pkgs-unstable.signal-desktop # <-- Rolling latest Signal
    openvpn
    warp-terminal
    gh
    fastfetch

  ];
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    #Import SnOrca Module
    snapmaker-orca.nixosModules.default
  ];

  # Define custom shell shortcut globally
   programs.bash.shellAliases = {
    rebuild = "sudo nixos-rebuild --flake /home/nakedsnake/Documents/GitHub/nixos-config";
    nixhomedir = "cd /home/nakedsnake/Documents/GitHub/nixos-config";
    editnixconfig = "kate /home/nakedsnake/Documents/GitHub/nixos-config/configuration.nix";
    editnixflake = "kate /home/nakedsnake/Documents/GitHub/nixos-config/flake.nix";
    nixclean = "sudo nix-env ---delete-generations 14d --profile /nix/var/nix/profiles/system && sudo nix-store --gc && sudo /nix/var/nix/profiles/system/bin/switch-to-configuration boot";
    nixhistory = "nix profile history --profile /nix/var/nix/profiles/system";
    vpnon = "sudo systemctl start openvpn-nordVPN.service";
    vpnoff = "sudo systemctl stop openvpn-nordVPN.service";
    vpnrestart = "sudo systemctl restart openvpn-nordVPN.service";
    vpnstatus = "systemctl status openvpn-nordVPN.service";
    myip = "curl ifconfig.me";
    };

  # Automatically fire hardware specs in terminal start
  programs.bash.interactiveShellInit = "fastfetch";

  # Enable Native Translation for standalone Linux Apps ex SnOrca
  programs.nix-ld.enable = true;

  # Install native SnOrca Flake
  programs.snapmaker-orca.enable = true;

  # Automated System Optimization and Cleanups
  nix = {
    settings = {
    experimental-features = [ "nix-command" "flakes"];
    auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
      };
    };


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-nitro5"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable Local Networ Service Discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
    enable = true;
    addresses = true;
    };
  };

  # Open mDNS port on Firewall
  networking.firewall.allowedUDPPorts = [ 5353 ];

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable X11 + KDE Plasma 6
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Bluetooth service
  hardware.bluetooth.enable = true;

  # Optional: enable auto power-on at boot
  hardware.bluetooth.powerOnBoot = true;


  # Enable OpenVPN
  services.openvpn.servers = {
    nordVPN = {
      config = ''
        config /home/nakedsnake/Documents/GitHub/OpenVPN/us5839.nordvpn.com.udp.ovpn
        auth-user-pass /etc/openvpn/nordvpn.cred
      '';
      autoStart = true; # Set to true to start on boot
      updateResolvConf = true; # Update DNS, if needed
    };
  };

  # Enable touchpad support (enabled by default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nakedsnake = {
    isNormalUser = true;
    description = "NakedSnake";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = commonPackages;
  };

  # Install Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Install Firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = commonPackages;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
