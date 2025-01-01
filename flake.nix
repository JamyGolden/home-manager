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
      # Detect the system based on the architecture and platform
      system = if builtins.getEnv "HOST_PLATFORM" != "" then
        builtins.getEnv "HOST_PLATFORM" # Use environment variable if available
      else if builtins.hasAttr "isDarwin" builtins && builtins.getEnv "NIX_SYSTEM_ARCH" == "arm64" then
        "aarch64-darwin" # Apple Silicon
      else if builtins.hasAttr "isDarwin" builtins then
        "x86_64-darwin" # Intel Mac
      else
        "x86_64-linux"; # Default to Linux
      stateVersion = "24.05"; # See https://nixos.org/manual/nixpkgs/stable for most recent
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
          inputs.agenix.homeManagerModules.default

          ./modules/shared/age.nix
          ./hosts/linux/pc.nix
          ./modules/shared/home-manager/home.nix
        ];
      };
  };
}
