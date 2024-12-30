{
  description = "Home Manager configuration of jamygolden";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, agenix } @ inputs:
    let
      username = "jamygolden";
      fullName = "Jamy Golden";
      email = "code@jamygolden.com";
      stateVersion = "24.05"; # See https://nixos.org/manual/nixpkgs/stable for most recent
      system = if builtins.hasAttr "isDarwin" builtins then "aarch64-darwin" else "x86_64-linux";

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
        dotfilesRepo = builtins.toString self;
        dotfilesRepoAbs = "${homeDirectory}/projects/jamygolden-home-manager";
        xdgBinHome = "${homeDirectory}/.local/bin";
      };
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit
            email
            fullName
            homeDirectory
            inputs
            paths
            stateVersion
            system
            username;
        };

        modules = [
          ./home-manager/home.nix
          inputs.agenix.homeManagerModules.default
        ];
      };
    };
}
