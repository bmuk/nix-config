let pkgs = import <nixpkgs> {};
  myHaskellPackages = pkgs.myHaskellPackages;
  haskellPackages = myHaskellPackages.override {
    extension = self: super: {
      todo = myHaskellPackages.callPackage ./. {};
    };
  };
in pkgs.lib.overrideDerivation haskellPackages.todo (attrs: {
  buildInputs = [ myHaskellPackages.cabalInstall pkgs.zsh ] ++ attrs.buildInputs;
  shellHook = ''
    pushd /home/bmuk/Code/todo/
  '';
})
