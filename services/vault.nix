{ config, pkg, ... }:
{
    services.vault = {
        enable = true;
        address = "https://vault.oxide.one";
        storageBackend = "raft";
    };

}