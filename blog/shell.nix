let pkgs = import <nixpkgs> {};
  myHaskellPackages = pkgs.myHaskellPackages;
  haskellPackages = myHaskellPackages;
in haskellPackages.callPackage ./default.nix {}