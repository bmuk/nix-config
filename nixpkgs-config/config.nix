{ pkgs }:

with pkgs;
let
  # Directories where I'll store extra packages.
  normalProjectDir = "/home/bmuk/Code/nix-config/";
  haskellProjectDir = normalProjectDir + "haskell-packages/";

  # Wrap callPackage with the default Haskell directories.
  haskellPackage = haskellPackageS {};
  haskellPackageS = s: p: s.callPackage (haskellProjectDir + p);

  # Wrap callPackage with the default non-Haskell directories.
  normalPackage = p: callPackage (normalProjectDir + p) {};
  normalPackage32 = p: callPackage_i686 (normalProjectDir + p) {};
  normalPackageS = s: p: s.callPackage (normalProjectDir + p) {};
  normalPackageC = s: p: v: s.callPackage (normalProjectDir + p) v;
in
{ packageOverrides = self: rec {

  # Haskell packages I want to use that reside out of nixpkgs or don't
  # have the settings I want.
  ownHaskellPackages = ver : recurseIntoAttrs (ver.override {
    extension = se : su : rec {

      # Packages required to build Yi
      ooPrototypes      = normalPackageS se "oo-prototypes";
      wordTrie          = normalPackageS se "word-trie";
      yi                = normalPackageS se "yi";
      yiContrib         = normalPackageS se "yi-contrib";
      yiHaskellUtils    = normalPackageC se "yi-haskell-utils";
      yiLanguage        = normalPackageS se "yi-language";
      yiMonokai         = normalPackageS se "yi-monokai";
      yiRope            = normalPackageS se "yi-rope";
    };
  });

  # Derive package sets for every version of GHC I'm interested in.
  myHaskellPackages_ghc742 = ownHaskellPackages haskellPackages_ghc742;
  myHaskellPackages_ghc763 = ownHaskellPackages haskellPackages_ghc763;
  myHaskellPackages_ghc783 = ownHaskellPackages haskellPackages_ghc783;
  myHaskellPackages_ghc783_profiling =
    ownHaskellPackages haskellPackages_ghc783_profiling;

  myHaskellPackages = myHaskellPackages_ghc783;
  myHaskellPackages_profiling = myHaskellPackages_ghc783_profiling;
};}
