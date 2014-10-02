let pkgs = import <nixpkgs> {};
  myHaskellPackages = pkgs.myHaskellPackages;
  haskellPackages = myHaskellPackages.override {
    extension = self: super: {
      blog = myHaskellPackages.callPackage ./. {};
    };
  };
in pkgs.lib.overrideDerivation haskellPackages.blog (attrs: {
  buildInputs = [ myHaskellPackages.cabalInstall pkgs.zsh ] ++ attrs.buildInputs;
  shellHook = ''
    pushd /home/bmuk/Code/parallel-haskell
  '';
})
