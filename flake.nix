{
  description = "Home Manager configuration of jamygolden";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, darwin, nixpkgs, home-manager }:
    let
      username = "jamygolden";
      fullName = "Jamy Golden";
      email = "code@jamygolden.com";
      stateVersion = "24.05"; # See https://nixos.org/manual/nixpkgs/stable for most recent
      system = builtins.currentSystem;

      pkgs = import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };
      };

      homeDirPrefix = if pkgs.stdenv.hostPlatform.isDarwin then "Users" else "home";
      homeDirectory = "/${homeDirPrefix}/${username}";
      
      paths = {
        projects = "${homeDirectory}/projects";
        dotfilesRepo = "${homeDirectory}/projects/${username}-home-manager";
        xdgBinHome = "${homeDirectory}/.local/bin";
      };

      # Darwin-specific module to enable experimental features
      darwinModule = if pkgs.stdenv.hostPlatform.isDarwin then
        { config, ... }: {
          nix.settings.experimental-features = [ "nix-command" "flakes" ];
        }
      else null;
    in {
      homeConfigurations.darwin = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit
            email
            fullName
            homeDirectory
            paths
            stateVersion
            username;
        };

        modules = [
          ./home-manager/home.nix
          (if darwinModule != null then darwinModule else null)
        ];
      };
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit
            email
            fullName
            homeDirectory
            paths
            stateVersion
            username;
        };

        modules = [
          ./home-manager/home.nix
        ];
      };
    };
}