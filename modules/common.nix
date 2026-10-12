{ ... }:
{

# Nix settings shared by every machine
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

# Time zone and language
time.timeZone = "America/Chicago";
i18n.defaultLocale = "en_US.UTF-8";
i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_INDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
};

# Allow unfree packages (Steam, Signal)
nixpkgs.config.allowUnfree = true;

# Your User, identical on every machine
users.users.nakedsnake = {
    isNormalUser = true;
    description = "NakedSnake";
    extraGroups = [ "wheel" ];
    };

# Aliases shared by every machine
  programs.bash.shellAliases = {
    rebuild = "sudo nixos-rebuild --flake /home/nakedsnake/Documents/GitHub/nixos-config";
    nixhomedir = "cd /home/nakedsnake/Documents/GitHub/nixos-config";
    editnixflake = "kate /home/nakedsnake/Documents/GitHub/nixos-config/flake.nix";
    nixhistory = "nix profile history --profile /nix/var/nix/profiles/system";
    nixclean = "sudo nix-env --delete-generations 14d --profile /nix/var/nix/profiles/system && sudo nix-store --gc && sudo /nix/var/nix/profiles/system/bin/switch-to-configuration boot";
    nixcheck = "find /home/nakedsnake/Documents/GitHub/nixos-config -name '*.nix' -exec nix-instantiate --parse {} + > /dev/null && echo 'Syntax OK'";
    vpnon = "sudo systemctl start openvpn-nordVPN.service";
    vpnoff = "sudo systemctl stop openvpn-nordVPN.service";
    vpnrestart = "sudo systemctl restart openvpn-nordVPN.service";
    vpnstatus = "systemctl status openvpn-nordVPN.service";
    myip = "curl ifconfig.me";
    };

}
