{
  network =  {
    description = "Gecko Deployment";
    ordering = {
      tags = [ "control_plane" ];
    };
  };

  "gecko-control-01" = { config, pkgs, ... }: 
  { 
    deployment.tags = [ "control_plane" ]; 
    imports = [./raspberry_pi.nix ./common];
    networking.interfaces.eth0.ipv4.addresses = [{ address = "10.0.1.11"; prefixLength = 25; }];
  };
  "gecko-control-02" = { config, pkgs, ... }: 
  { 
    deployment.tags = [ "control_plane" ]; 
    imports = [./raspberry_pi.nix ./common];
    networking.interfaces.eth0.ipv4.addresses = [{ address = "10.0.1.12"; prefixLength = 25; }];
  };
  "gecko-control-03" = { config, pkgs, ... }: 
  { 
    deployment.tags = [ "control_plane" ]; 
    imports = [./raspberry_pi.nix ./common];
    networking.interfaces.eth0.ipv4.addresses = [{ address = "10.0.1.13"; prefixLength = 25; }];
  };
    
}
