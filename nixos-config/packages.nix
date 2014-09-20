{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    chromium = {
      enablePepperFlash = true;
      enablePepperPDF = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # Shells
    zsh
    bash
    fish
    # Terminals
    xfce.terminal
    rxvt_unicode
    e17.terminology
    # Monitoring
    htop
    iotop
    atop
    dnstop
    iftop
    jnettop
    # Editors
    emacs
    vim
    # Xmonad Utils
    compton
    xscreensaver
    dmenu
    pmutils
    scrot
    screen
    xclip
    dunst
    libnotify
    # Browsers
    chromium
    torbrowser
    conkeror
    uzbl
    surf
    dwb
    # Development Tools
    git
    tree
    autojump
    cloc
    glib
    elfutils
    gnumake
    gdb
    haskellPackages.cabal2nix
    nodePackages.npm2nix
    nix-repl
    # Android
    androidsdk_4_1
    # Personal Cloud Storage
    gitAndTools.gitAnnex
    # Encryption
    gnupg1
    gnupg
    gnutls
    pinentry
    scrypt
    aescrypt
    aespipe
    # Networking
    wget
    mosh
    nmap
    inetutils
    openvpn
    aircrackng
    wireshark
    sshfsFuse
    arp-scan
    ncat
    iodine
    tor
    cjdns
    # Torrents
    rtorrent
    # Security
    snort
    ddrescue
    # Study Tools
    evince
    mupdf
    anki
    tesseract
    R
    # Video
    (mpv.override { pulseSupport = false; })
    python27Packages.livestreamer
    rtmpdump
    youtubeDL
    # Audio
    cmus
    (mpd.override { pulseaudioSupport = false; })
    ncmpcpp
    # Images
    libpng
    gimp
    mcomix
    xfce.ristretto
    # Graphics
    gtk3
    glxinfo
    # File Tools
    unzip
    file
    lsof
    p7zip
    zip
    # Misc
    xboxdrv
  ];

  programs = {
    zsh.enable = true;
    bash.promptInit = "PS1=\"# \"";
    ssh.startAgent = false;
  };
}