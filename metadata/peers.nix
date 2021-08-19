# Rip of Cadey's code
{ writeTextFile, lib, ... }:
let
  metadata = lib.importTOML ../network.toml;
  hostName = { hostName, ... }:
  let
    host = metadata.hosts."${host}";
    network = metadata."${host.network}";
  in {
    hostName = "${host}"."${network.domain}";
    fqdn = "${hostName}.${metadata.meta.location}.${metadata.meta.domain}";
    hostsFile = "${host.address} ${hostName} ${fqdn}";
    
  };
#   roamPeer = { network, wireguard, ... }:
#     let
#       net = metadata.networks."${network}";
#       v6subnet = net.ula;
#       extraAddrs = ({ extra_addrs ? [ ], ... }: extra_addrs) wireguard;
#     in {
#       allowedIPs = [
#         "${metadata.common.ula}:${wireguard.addrs.v6}/128"
#         "${metadata.common.gua}:${wireguard.addrs.v6}/128"
#         "${wireguard.addrs.v4}/32"
#       ] ++ extraAddrs;
#       publicKey = wireguard.pubkey;
#     };
#   serverPeer = { network, wireguard, ip_addr, ... }:
#     let
#       net = metadata.networks."${network}";
#       v6subnet = net.ula;
#       extraAddrs = ({ extra_addrs ? [ ], ... }: extra_addrs) wireguard;
#     in {
#       allowedIPs = [
#         "${metadata.common.ula}:${wireguard.addrs.v6}/128"
#         "${metadata.common.gua}:${wireguard.addrs.v6}/128"
#         "${wireguard.addrs.v4}/32"
#       ] ++ (if ip_addr == "10.77.3.1" then [ "10.77.0.0/16" ] else [ ])
#         ++ extraAddrs;
#       publicKey = wireguard.pubkey;
#       persistentKeepalive = 25;
#       endpoint = "${ip_addr}:${toString wireguard.port}";
#     };
#   interfaceInfo = { network, wireguard, ... }:
#     peers:
#     let
#       net = metadata.networks."${network}";
#       v6subnet = net.ula;
#     in {
#       ips = [
#         "${metadata.common.ula}:${wireguard.addrs.v6}/128"
#         "${metadata.common.gua}:${wireguard.addrs.v6}/128"
#         "${wireguard.addrs.v4}/32"
#       ];
#       privateKeyFile = "/root/wireguard-keys/private";
#       listenPort = wireguard.port;
#       inherit peers;
#     };
in with metadata.hosts; rec {
  # expected peer lists
  hosts = [
    # cloud
    (hostName gecko-control-01)
    (hostName gecko-control-02)
    (hostName gecko-control-03)
  ];


  raw = metadata.hosts;
}
