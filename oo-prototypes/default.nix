{ cabal }:
let pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  file = builtins.readFile /home/bmuk/Code/oo-prototypes/oo-prototypes.cabal;
  strs = lib.strings.splitString "\n" file;
  vstr = builtins.head (builtins.filter (s: lib.strings.hasPrefix "version:" s) strs);
  vrsn = lib.strings.removePrefix "version:" (lib.strings.replaceChars [" "] [""] vstr);

in
cabal.mkDerivation (self: {
  pname = "oo-prototypes";
  version = vrsn;
  src = /home/bmuk/Code/oo-prototypes;
  meta = {
    homepage = "https://github.com/yi-editor/oo-prototypes";
    description = "Support for OO-like prototypes";
    license = self.stdenv.lib.licenses.gpl2;
    platforms = self.ghc.meta.platforms;
  };
})