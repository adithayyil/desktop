{
  description = "nixos conf for think";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    copyparty.url = "github:9001/copyparty";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      deploy-rs,
      copyparty,
      ...
    }:
    let
      mkSystem =
        configName: hostname:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit hostname copyparty;
          };
          modules = [ ./hosts/${configName}/configuration.nix ];
        };
    in
    {
      nixosConfigurations = {
        think = mkSystem "think" "think";
        meth = mkSystem "meth" "meth";
      };

      homeConfigurations."adi@think" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        modules = [ ./home ];
      };

      deploy.nodes.meth = {
        hostname = "meth";
        profiles.system = {
          sshUser = "adi";
          user = "root";
          path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.meth;
        };
      };

      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
