{ hostname, inputs, lib, ...}:
{
    imports = [
        inputs.nixos-hardware.nixosModules.common-pc
    ] ++ lib.optional (builtins.pathExists ./hosts/${hostname}) ./hosts/${hostname};

    hardware.enableRedistributableFirmware = true;

    nixpkgs = {
        hostPlatform = lib.mkDefault "${platform}";
        config = {
            allowUnfree = true;
        };
    };

    networking = {
        hostName = hostname;
        useDHCP = lib.mkDefault true;
    };

    nix =
        let
            flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
        in
    {
        settings = {
            experimental-features = "flakes nix-command";
            # Disable global registry
            flake-registry = "";
            warn-dirty = false;
            trusted-users = [
                "root"
            ];
        };
        # Disable channels
        channel.enable = false;
        # Make flake registry and nix path match flake inputs
        registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
        nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

    system = {
        inherit stateVersion;
    };
}