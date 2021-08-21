{ config, pkgs, ... }:
{
     environment.systemPackages = with pkgs; [
      vault
    ];
    services.vault = {
        enable = true;
        address = "https://vault.oxide.one";
        storageBackend = "raft";
    };

}