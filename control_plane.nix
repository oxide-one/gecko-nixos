{ hostName, ip_address, ... }:
{
    networking.hostName = hostName;
    services.vault.node_id = hostName;

    networking.interfaces.eth0.ipv4.addresses = [
    { 
        address = ip_address;
        prefixLength = 25; 
    }
    ];

    imports = [
        ./raspberry_pi.nix
        ./common
        ./services/vault.nix
    ];
}