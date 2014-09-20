{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./network.nix
      ./packages.nix
      ./security.nix
      ./xserver.nix
    ];
  
  boot = {
    consoleLogLevel = 3;
    extraTTYs = [ "tty8" ];
    loader.grub = {
      enable = true;
      timeout = 1;
      version = 2;
      splashImage = ./background.png;
      device = "/dev/sda";
    };
    kernelPackages = pkgs.linuxPackages_3_16;
    initrd.kernelModules = [
      "tun"
    ];
    cleanTmpDir = true;
    kernelParams = [ "quiet" "splash" ];
  };

  time.timeZone = "America/New_York";

  nix = {
    gc.automatic = false;
  };

  services = {
    ntp.enable = true;
    nixosManual.showManual = true;
    printing.enable = true;
    upower.enable = true;
    locate = {
      enable = true;
      period = "00 15 * * *";
    };
    redshift = {
      enable = true;
      latitude = "28.10";
      longitude = "-81.82";
    };
  };

  systemd = {
    services = {
      redshift = {
        restartIfChanged = false;
        requires = [ "network.target" ];
      };
    };
  };
  
  users = {
    mutableUsers = false;
    defaultUserShell = "/var/run/current-system/sw/bin/zsh";
    extraUsers.bmuk = {
      uid = 1000;
      createHome = true;
      home = "/home/bmuk";
      description = "Britt Mathis";
      group = "users";
      extraGroups = [ "bmuk" "wheel" "adb" ];
      useDefaultShell = true;
      passwordFile = "/root/.bmuk";
    };
  };
}
