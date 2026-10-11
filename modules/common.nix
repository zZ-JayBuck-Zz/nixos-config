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

}
