# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-unstable, snapmaker-orca, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    #Import SnOrca Module
    snapmaker-orca.nixosModules.default
  ];

  # Define custom shell shortcut globally
   programs.bash.shellAliases = {
    editnixconfig = "kate /home/nakedsnake/Documents/GitHub/nixos-config/hosts/nitro5/default.nix";
    };

  # Automatically fire hardware specs in terminal start
  programs.bash.interactiveShellInit = "fastfetch";

  # Enable Native Translation for standalone Linux Apps ex SnOrca
  programs.nix-ld.enable = true;

  # Install native SnOrca Flake
  programs.snapmaker-orca.enable = true;


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



  # Enable Bluetooth service
  hardware.bluetooth.enable = true;

  # Optional: enable auto power-on at boot
  hardware.bluetooth.powerOnBoot = true;

  # Enable touchpad support (enabled by default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nakedsnake.extraGroups = [ "networkmanager" ];



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
