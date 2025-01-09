
{ username, email, fullName, homeDirectory, stateVersion, inputs, self, system }:

let
  pkgs = import inputs.nixpkgs {
    overlays = [inputs.rust-overlay.overlays.default];
    inherit system;

    config = {
      allowUnfree = true;
    };
  };
  paths = {
    xdgBinHome = "${homeDirectory}/.local/bin";
    projects = "${homeDirectory}/projects";
    dotfilesRepo = builtins.toString self;
    dotfilesRepoAbs = "${homeDirectory}/projects/jamygolden-home-manager";
  };
in {
  inherit pkgs system;

  modules = [
    inputs.home-manager.darwinModules.home-manager
    inputs.mac-app-util.darwinModules.default

    (import ./configuration.nix {
      inherit
        homeDirectory
        pkgs
        username
        paths;
    })
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${username}.imports = [
          inputs.mac-app-util.homeManagerModules.default

          (import ./home-manager/home.nix {
            inherit
              email
              fullName
              homeDirectory
              paths
              pkgs
              stateVersion
              username;
          })
        ];
      };
    }

    inputs.agenix.darwinModules.default
    (import ../../modules/age.nix {
      homeDirectory = "${homeDirectory}";
      secretsDir = "${homeDirectory}/.config/agenix/agenix";
      secretsMountPoint = "${homeDirectory}/.config/agenix/agenix.d";
    })
  ];
}
