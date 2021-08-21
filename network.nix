{
  network =  {
    description = "Gecko Deployment";
    ordering = {
      tags = [ "control_plane" ];
    };
  };
    "gecko-control-01" = { pkgs, ... }:
    let
      metadata = pkgs.callPackage ./metadata/peers.nix {};
      shortHostName = "gecko-control-01";
      hostInfo = metadata.rawhosts."${shortHostName}";
    in
    {
      # Metadata for deployment
      deployment.tags = [ hostInfo.group ];
      #deployment.targetHost = hostInfo.address;
      #deployment.targetUser = "gecko";
      imports = [ 
        (import ./control_plane.nix shortHostName)
      ];
    };

    "gecko-control-02" = { pkgs, ... }:
    let
      metadata = pkgs.callPackage ./metadata/peers.nix {};
      shortHostName = "gecko-control-02";
      hostInfo = metadata.rawhosts."${shortHostName}";
    in
    {
      # Metadata for deployment
      deployment.tags = [ hostInfo.group ];
      #deployment.targetHost = hostInfo.address;
      #deployment.targetUser = "gecko";
      imports = [ 
        (import ./control_plane.nix shortHostName)
      ];
    };

    "gecko-control-03" = { pkgs, ... }:
    let
      metadata = pkgs.callPackage ./metadata/peers.nix {};
      shortHostName = "gecko-control-03";
      hostInfo = metadata.rawhosts."${shortHostName}";
    in
    {
      # Metadata for deployment
      deployment.tags = [ hostInfo.group ];
      #deployment.targetHost = hostInfo.address;
      #deployment.targetUser = "gecko";
      imports = [ 
        (import ./control_plane.nix shortHostName)
      ];
    };
}

