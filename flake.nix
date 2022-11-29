{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    {
      # Linux hosts
      homeConfigurations.linux = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./home.nix
          {
            home = {
              username = "kergoth";
              homeDirectory = "/home/kergoth";
            };
          }
        ];
      };

      # Linux hosts with local home directories on /mel
      homeConfigurations.work = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./home.nix
          {
            home = {
              username = "kergoth";
              homeDirectory = "/mel/kergoth";
            };
          }
        ];
      };

      # Linux hosts with local home directories on /data
      homeConfigurations.work_data = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./home.nix
          {
            home = {
              username = "kergoth";
              homeDirectory = "/data/kergoth";
            };
          }
        ];
      };

      # macOS hosts
      homeConfigurations.darwin = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-darwin;
        modules = [
          ./home.nix
          {
            home = {
              username = "kergoth";
              homeDirectory = "/Users/kergoth";
            };
            xdg.cacheHome = "/Users/kergoth/Library/Cache";
          }
        ];
      };
    };
}
