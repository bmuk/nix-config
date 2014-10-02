{ config, pkgs, ... }:

{
  imports = [ ./private.nix ];
  
  # Set my hostname and use wpa_supplicant to manage wifi
  networking = {
    hostName = "bmuk-laptop";
    interfaceMonitor.enable = false;
    wireless.enable = false;
    useDHCP = false;
    wicd.enable = true;
  };
  
  services = {
    openssh.enable = true;
    tor = {
      client.enable = true;
      torify.enable = true;
    };
    openvpn = {
      enable = true;
      servers = {
        client = {
          config = ''
            client
            dev tun
            proto tcp
            remote 199.193.117.84 443
            resolv-retry infinite
            nobind
            persist-key
            persist-tun
            ca /root/ca.crt
            tls-client
            remote-cert-tls server
            auth-user-pass /root/login.conf
            comp-lzo
            verb 1
            reneg-sec 0
            crl-verify /root/crl.pem
          '';
          up = "echo nameserver $nameserver | ${pkgs.openresolv}/sbin/resolvconf -m 0 -a $dev";
          down = "${pkgs.openresolv}/sbin/resolvconf -d $dev";
        };
      };
    };
  };
}
