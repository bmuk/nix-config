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
    extraHosts = ''
      fc5d:baa5:61fc:6ffd:9554:67f0:e290:7535 nodeinfo.hype
      fcbf:7bbc:32e4:716:bd00:e936:c927:fc14 socialno.de
      fcd5:76e1:c1c2:e946:b266:8543:c1d5:67ac hypeoverflow.com
    '';
    interfaces = {
      tun0.virtual = true;
      tun1.virtual = true;
    };    
  };
  
  services = {
    openssh.enable = true;
    tor = {
      client.enable = true;
      torify.enable = true;
    };
    cjdns = {
      enable = true;
      UDPInterface = {
        bind = "192.168.1.32:43211";
      };
    };
    openvpn = {
      enable = true;
      servers = {
        client = {
          config = ''
            client
	    dev tun0
            proto udp
            remote 199.193.117.44 1194
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
  systemd.services = {
    openvpn-client.requires = [ "network.target" ];
    cjdns.requires = [ "openvpn-client.service" ];
  };
}
