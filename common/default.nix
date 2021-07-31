{ config, pkgs, ... }:

{
    # Gecko User
    users.users.gecko = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILYxjBKpRNz9cQsM30+FF6X74dgWceqQ/cvUdDBSzV1q"
        ];
    };

    # Automatically log in at the virtual consoles.
    # This might sound like a security issue, but I work remotely and my servers sit next to me :p
    services.getty.autologinUser = "gecko";
    
    # Enable SSH
    services.openssh.enable = true;
    
    # Add the Gecko user to the root authorized keys
    users.users.root.openssh.authorizedKeys.keys =
        config.users.users.gecko.openssh.authorizedKeys.keys;

    # Optimize the nix store automagically
    nix.autoOptimiseStore = true;

    nix.trustedUsers = ["root" "@wheel"];
    # Add a MOTD to read
    users.motd = builtins.readFile ./motd;

    # Disable Sudo password requirements
    security.sudo.wheelNeedsPassword = false;

    environment.systemPackages = with pkgs; [
    # customize as needed!
    vim git htop
    ];
    # Miscellaneous
    time.timeZone = "Europe/London";
}
