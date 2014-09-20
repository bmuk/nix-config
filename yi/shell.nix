let pkgs = import <nixpkgs> {};
  myHaskellPackages = pkgs.myHaskellPackages;
  haskellPackages = myHaskellPackages.override {
    extension = self: super: {
      yi = myHaskellPackages.callPackage ./. {};
    };
  };
in pkgs.lib.overrideDerivation haskellPackages.yi (attrs: {
  noHaddock = true;
  buildInputs = [ myHaskellPackages.cabalInstall ] ++ attrs.buildInputs;
})
