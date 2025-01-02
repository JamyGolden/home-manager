{
  config,
  email,
  fullName,
  inputs,
  paths,
  stateVersion,
  system,
  username,
  ...
  }: {
   home-manager = {
     useGlobalPkgs = true;
     useUserPackages = true;
     extraSpecialArgs = {
       inherit
         email
         fullName
         inputs
         paths
         stateVersion
         system
         username;
     };
     users.${builtins.readFile
    config.age.secrets.workEmail.path}.imports = [ ./work.nix ];
   };
}
