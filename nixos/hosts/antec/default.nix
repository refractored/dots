{ inputs, ...}:
{
    imports = [
        inputs.nixos-hardware.nixosModules.common-pc-ssd
        inputs.nixos-hardware.nixosModules.common-cpu-amd
        inputs.nixos-hardware.nixosModules.common-gpu-nvidia
        ./services
    ];

    hardware.nvidia ={
        enabled = true;
        open = true;
    };
}