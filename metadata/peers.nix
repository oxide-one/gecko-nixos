# Rip of Cadey's code
# Original source from Xe/
{ writeTextFile, lib, ... }:
with lib;
let
  metadata = importTOML ../network.toml;

  # Generate a hostsFile entry
  hostsLine = meta: 
  let
    shortHostName = meta.hostname;
    network = metadata."${meta.network}";
    ip_address = meta.address;
    fqdn = makefqdn meta;
  in "${ip_address} ${fqdn} ${shortHostName}";
  # Generate a raw FQDN
  makefqdn = meta:
  let
    shortHostName = meta.hostname;
    network = metadata."${meta.network}";
    fqdn = "${shortHostName}.${network.domain}.${metadata.meta.location}.${metadata.meta.domain}";
  in fqdn;

  makeSubdomain = meta:
  let
    shortHostName = meta.hostname;
    network = metadata."${meta.network}";
  in "${network.domain}.${metadata.meta.location}.${metadata.meta.domain}";

  # Generate search domains
  searchDomains = meta:
  let
    network = metadata."${meta.network}";
    baseDomain = metadata.meta.domain;
    localDomain = "${metadata.meta.location}.${baseDomain}";
    subDomain = "${network.domain}.${localDomain}";
  in [subDomain localDomain baseDomain ];

  # Generate a DNS entry
  dnsEntry = meta: "${meta.address} ${meta.name}";
  # Make all entries
  makeAll = meta: {fqdn = makefqdn meta; hostsLine = hostsLine meta; subdomain = makeSubdomain meta; searchDomains = searchDomains meta;};

in with metadata; rec {
  # Set the raw values
  raw = metadata;
  rawhosts = metadata.hosts;
  # Set the networks
  networks = {
    core = metadata.core;
    management = metadata.management;
    out = metadata.out;
  };
  # expected peer lists
  hostsFile =
    ''
    # Gecko Control
    ${hostsLine raw.hosts.gecko-control-01}
    ${hostsLine raw.hosts.gecko-control-02}
    ${hostsLine raw.hosts.gecko-control-03}
    # Switches
    ${hostsLine raw.hosts.switch-01}
    ${hostsLine raw.hosts.switch-02}
    # Primary Router
    ${hostsLine raw.hosts.router-01}
    # Management interfaces for hypervisors
    ${hostsLine raw.hosts.gecko-hypervisor-01-mgmt}
    ${hostsLine raw.hosts.gecko-hypervisor-02-mgmt}
    ${hostsLine raw.hosts.gecko-hypervisor-03-mgmt}

    ${dnsEntry dns.vault}
    ${dnsEntry dns.kubernetes}
  '';
  
  func.makeAll = makeAll;
  func.hostsLine = hostsLine;
  func.searchDomains = searchDomains;
}
 
  
