{ username, email, fullName, homeDirectory, stateVersion, inputs, self, system }:

let
  pkgs = import inputs.nixpkgs {
    inherit system;

    config = {
      allowUnfree = true;
    };
  };
in {
  inherit pkgs;

  extraSpecialArgs = {
    inherit
      email
      fullName
      inputs
      pkgs
      stateVersion
      username;

      homeDirectory = "${homeDirectory}";
      paths = {
        projects = "${homeDirectory}/projects";
        dotfilesRepo = builtins.toString self;
        dotfilesRepoAbs = "${homeDirectory}/projects/jamygolden-home-manager";
        xdgBinHome = "${homeDirectory}/.local/bin";
      };
  };

  modules = [
    inputs.agenix.homeManagerModules.default

    ./configuration.nix
    ./home-manager/home.nix

    (import ../../modules/age.nix {
      homeDirectory = "${homeDirectory}";
      secretsDir = "${homeDirectory}/.config/agenix/agenix";
      secretsMountPoint = "${homeDirectory}/.config/agenix/agenix.d";
    })
  ];
}
