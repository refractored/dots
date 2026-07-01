_:
{
    boot = {
        loader = {
            systemd-boot.enable = false;
            efi.canTouchEfiVariables = true;
            timeout = 15;

            grub = {
                enable = true;
                device = "nodev";
                efiSupport = true;
                useOSProber = true;
            };
        };
    };
}