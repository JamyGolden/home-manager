{ username, email, fullName, homeDirectory, stateVersion, inputs, self, system }:

{
  pkgs = import inputs.nixpkgs {
    inherit system;

    config = {
      allowUnfree = true;
    };
  };

  extraSpecialArgs = {
    inherit
      email
      fullName
      stateVersion
      username;

      agenixPkg = inputs.agenix.packages.${system}.agenix;
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
