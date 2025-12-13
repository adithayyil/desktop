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
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      deploy-rs,
      ...
    }:
    let
      # Helper function to create system configurations
      mkSystem =
        configName: hostname:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit hostname; };
          modules = [ ./hosts/${configName}/configuration.nix ];
        };
    in
    {
      # System configurations
      nixosConfigurations = {
        think = mkSystem "think" "think";
        server = mkSystem "server" "methamphetamine";
      };

      # home-manager configuration
      homeConfigurations."adi@think" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        modules = [ ./home ];
      };

      # deploy-rs configuration
      deploy.nodes.server = {
        hostname = "10.0.0.76";
        profiles.system = {
          sshUser = "adi";
          user = "root";
          path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.server;
        };
      };

      # Validation checks
      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
