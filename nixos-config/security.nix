{ config, pkgs, ... }:

{
  security = {
    sudo.configFile = ''
      Cmnd_Alias SUSPEND = /var/run/current-system/sw/sbin/pm-suspend, /var/run/current-system/sw/bin/systemctl suspend
      Defaults:root,%wheel env_keep+=TERMINFO_DIRS
      Defaults:root,%wheel env_keep+=TERMINFO
      Defaults env_keep+=SSH_AUTH_SOCK
      %wheel      ALL=(ALL) SETENV: ALL
      %users      ALL=NOPASSWD: SUSPEND
    '';
    polkit.extraConfig = ''
      polkit.addRule(function(action) {
        if (action.id == "org.freedesktop.udisks2.filesystem-mount-system") {
	  return polkit.Result.YES;
	}
      });
    '';
  };
}