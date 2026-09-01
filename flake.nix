{
  description = "macOS setup with nix-darwin and Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
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
