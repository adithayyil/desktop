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

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    copyparty.url = "github:9001/copyparty";

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      deploy-rs,
      sops-nix,
      copyparty,
      nvf,
      ...
    }:
    let
      mkSystem =
        configName: hostname:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit hostname copyparty sops-nix;
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
        modules = [
          nvf.homeManagerModules.default
          ./home
        ];
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
