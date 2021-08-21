shortHostName: {config, pkgs, ... }:
let 
    metadata = pkgs.callPackage ./metadata/peers.nix {};
    hostInfo = metadata.rawhosts."${shortHostName}" // (metadata.func.makeAll metadata.rawhosts."${shortHostName}");
    netInfo = metadata.networks."${hostInfo.network}";
in
{  
    # Set the hostname and domain
    networking.hostName = hostInfo.hostname;
    networking.domain = hostInfo.subdomain;
    # Set the search domains
    networking.search = hostInfo.searchDomains;
    networking.extraHosts = metadata.hostsFile;
    networking = {
        dhcpcd.enable = false;
        usePredictableInterfaceNames = false;
        defaultGateway = netInfo.gateway;
        nameservers = netInfo.dns;
    };
    # Set the management interface
    networking.interfaces."${hostInfo.interface}"= {
        ipv4.addresses = [
        { 
            address = hostInfo.address;
            prefixLength = 25; 
        }
        ];
        mtu = 9000;
    };
    
    imports = [
        ./raspberry_pi.nix
        ./common
        ./services/vault.nix
    ];
}