{ inputs, outputs, stateVersion, ... }:

{
    makeNixOS = { hostname, desktop ? false, platform ? "x86_64-linux" }: inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
            inherit inputs outputs stateVersion hostname desktop platform;
        };
        modules = [
            ./nixos
        ];
    };

    makeHome = { hostname, username, desktop ? false, platform ? "x86_64-linux" }: inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${platform};
        specialArgs = {
            inherit inputs outputs stateVersion hostname username desktop platform;
        };
        modules = [
            ./home
        ];
    };

    forAllSystems = inputs.nixpkgs.lib.genAttrs[
        "x86_64-linux"
        "aarch64-linux"
    ];
}