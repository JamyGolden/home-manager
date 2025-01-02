
{ username, email, fullName, homeDirectory, stateVersion, inputs, self, system }:

{
  inherit system;

  pkgs = import inputs.nixpkgs {
    inherit system;

    config = {
      allowUnfree = true;
    };
  };

  modules = [
    inputs.home-manager.darwinModules.home-manager

    (import ./configuration.nix { inherit homeDirectory; })
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${username}.imports = [
          (import ./home-manager/home.nix {
    inherit
      email
      fullName
      homeDirectory
      stateVersion
      username;

      agenixPkg = inputs.agenix.packages.${system}.agenix;
      paths = {
        projects = "${homeDirectory}/projects";
        dotfilesRepo = builtins.toString self;
        dotfilesRepoAbs = "${homeDirectory}/projects/jamygolden-home-manager";
        xdgBinHome = "${homeDirectory}/.local/bin";
      };

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
