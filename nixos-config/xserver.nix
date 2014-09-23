{ config, pkgs, ... }:

{
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      clearlyU
      cm_unicode
      freefont_ttf
      terminus_font
      ttf_bitstream_vera
      inconsolata
      ubuntu_font_family
      dejavu_fonts
    ];
  };
  # Enable Xorg and Keyboard Options
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "ctrl:nocaps";
    startGnuPGAgent = true;
    # Setup Trackpad
    synaptics = {
      enable = true;
      twoFingerScroll = true;
    };
    # Display Manager Setup
    displayManager = {
      slim = {
        enable = true;
	autoLogin = false;
	defaultUser = "bmuk";
	theme = pkgs.fetchurl {
          url = https://github.com/jagajaga/nixos-slim-theme/archive/1.0.tar.gz;
          sha256 = "08ygjn5vhn3iavh36pdcb15ij3z34qnxp20xh3s1hy2hrp63s6kn";
        };
      };
      sessionCommands = ''
        xsetroot -cursor_name left_ptr
        compton &
	xscreensaver -no-splash &
	feh --bg-fill --randomize /home/bmuk/.wallpapers
	git annex assistant --autostart &
	dzen2 &
	urxvtd &
	emacs --daemon &
	xrdb -merge /home/bmuk/.Xresources
      '';
    };
    # Xmonad Setup
    windowManager = {
      xmonad = {
        enable = true;
	enableContribAndExtras = true;
      };
      default = "xmonad";   
    };
    # Desktop Environment Integration
    desktopManager = {
      xterm.enable = false;
      default = "none";
    };
  };
}
