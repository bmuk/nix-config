{ cabal, binary, derive, hspec, QuickCheck }:
let pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  file = builtins.readFile /home/bmuk/Code/word-trie/word-trie.cabal;
  strs = lib.strings.splitString "\n" file;
  vstr = builtins.head (builtins.filter (s: lib.strings.hasPrefix "version:" s) strs);
  vrsn = lib.strings.removePrefix "version:" (lib.strings.replaceChars [" "] [""] vstr);

in
cabal.mkDerivation (self: {
  pname = "word-trie";
  version = vrsn;
  src = /home/bmuk/Code/word-trie;
  buildDepends = [ binary derive ];
  testDepends = [ binary hspec QuickCheck ];
  meta = {
    homepage = "https://github.com/yi-editor/yi";
    description = "Implementation of a finite trie over words";
    license = self.stdenv.lib.licenses.gpl2;
    platforms = self.ghc.meta.platforms;
    maintainers = with self.stdenv.lib.maintainers; [ fuuzetsu ];
  };
})
