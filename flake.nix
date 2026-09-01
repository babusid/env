{
  description = "macOS setup with nix-darwin and Home Manager";

  inputs = {
    nixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz";
    nix-darwin.url = "https://github.com/nix-darwin/nix-darwin/archive/master.tar.gz";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "https://github.com/zhaofengli-wip/nix-homebrew/archive/master.tar.gz";
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      home-manager,
      nix-homebrew,
      ...
    }:
    let
      appleSiliconSystem = "aarch64-darwin";
    in
    {
      lib.mkAppleSiliconMacBook =
        {
          username,
          homeDirectory ? "/Users/${username}",
        }:
        nix-darwin.lib.darwinSystem {
          system = appleSiliconSystem;
          specialArgs = {
            inherit username homeDirectory;
          };
          modules = [
            ./modules/darwin
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                enableRosetta = true;
                user = username;
                mutableTaps = true;
              };

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit username homeDirectory;
              };
              home-manager.users.${username} = import ./home;
            }
          ];
        };

      darwinModules.appleSiliconMacBook = ./modules/darwin;
      homeModules.default = ./home;

      formatter.${appleSiliconSystem} = nixpkgs.legacyPackages.${appleSiliconSystem}.nixfmt-rfc-style;
    };
}
