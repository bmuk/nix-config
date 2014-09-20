{ cabal, binary, deepseq, fingertree, hspec, QuickCheck
, quickcheckInstances, text
}:


let pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  sr  = "/home/bmuk/Code/yi-rope";
  file = builtins.readFile (sr + "/yi-rope.cabal");
  strs = lib.strings.splitString "\n" file;
  vstr = builtins.head (builtins.filter (s: lib.strings.hasPrefix "version:" s) strs);
  vrsn = lib.strings.removePrefix "version:" (lib.strings.replaceChars [" "] [""] vstr);

in
cabal.mkDerivation (self: {
  pname = "yi-rope";
  version = vrsn;
  src = sr;
  buildDepends = [ binary deepseq fingertree text ];
  testDepends = [ hspec QuickCheck quickcheckInstances text ];
  meta = {
    description = "A rope data structure used by Yi";
    license = self.stdenv.lib.licenses.gpl3;
    platforms = self.ghc.meta.platforms;
  };
})
