{
  network =  {
    description = "Gecko Deployment";
    ordering = {
      tags = [ "control_plane" ];
    };
  };
    "gecko-control-01" = { ... }:
    let
      hostName = "gecko-control-01";
      ip_address = "10.0.1.11";
    in
    { 
      deployment.tags = [ "control_plane" ]; 
      imports = [
        ./control_plane.nix hostName ip_address
      ];
    };

    "gecko-control-02" = { ... }: 
    { 
      deployment.tags = [ "control_plane" ]; 
      imports = [./hosts/gecko-control-02/configuration.nix];
    };

    "gecko-control-03" = { config, pkgs, lib, ... }: 
    { 
      deployment.tags = [ "control_plane" ];
      imports = [./hosts/gecko-control-03/configuration.nix];
    };
}
