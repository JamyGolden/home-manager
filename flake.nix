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
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # this is a quick util a good GitHub samaritan wrote to solve for
    # https://github.com/nix-community/home-manager/issues/1341#issuecomment-1791545015
    mac-app-util = {
      url = "github:hraban/mac-app-util";
    };
  };

  outputs = { self, nixpkgs, home-manager, agenix, darwin, rust-overlay, mac-app-util } @ inputs:
    let
      username = "jamygolden";
      fullName = "Jamy Golden";
      email = "code@jamygolden.com";
      stateVersion = "24.05"; # See https://nixos.org/manual/nixpkgs/stable for most recent

      hostsHomeLinux = (import ./hosts/home-linux/flake-setup.nix {
        inherit username email fullName stateVersion inputs self;
        homeDirectory = "/home/${username}";
        system = "x86_64-linux";
      });
      hostsPersonalMacBookPro = (import ./hosts/personal-macbookpro/flake-setup.nix {
        inherit username email fullName stateVersion inputs self;
        homeDirectory = "/Users/${username}";
        system = "x86_64-darwin";
      });
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration hostsHomeLinux;

      darwinConfigurations.Jamys-MacBook-Pro = darwin.lib.darwinSystem hostsPersonalMacBookPro;
  };
}
