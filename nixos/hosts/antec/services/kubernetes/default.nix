{ inputs, ...}:

{
    services.k3s = {
        enable = true;
        extraArgs = [
            "--disable=traefik"
        ];
        role = "server";
    };

    networking.firewall = {
        allowedTCPPorts = [ 2379 2380 6443 7946 10250 ];
        allowedUDPPorts = [ 8472 ];
    };

    virtualisation.containerd.enable = true;

    environment = {
        defaultPackages = with pkgs; [ fluxcd ];
        systemPackages = with pkgs; [
            nfs-utils
            cifs-utils
        ];
    };

    services.openiscsi = {
        enable = true;
        name = "${config.networking.hostName}-initiatorhost";
    };
}