{
    description = "server";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

        home-manager.url = "github:nix-community/home-manager/release-26.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        sops-nix.url = "github:Mic92/sops-nix";
        sops-nix.inputs.nixpkgs.follows = "nixpkgs";

        nixos-hardware.url = "github:nixos/nixos-hardware/master";

        # colmena.url = "github:zhaofengli/colmena";
    };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      stateVersion = "26.05";
      helper = import ./helpers.nix { inherit inputs outputs stateVersion; };
    in
    {
      homeConfigurations = {
        "david@antec" = helper.makeHome {
          hostname = "antec";
          username = "david";
        };
      };

      nixosConfigurations = {
        antec = helper.makeNixOS {
            hostname = "antec";
        };
      };
    };
}
