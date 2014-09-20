{ cabal, filepath, lens, mtl, split, time, transformersBase, yi }:

cabal.mkDerivation (self: {
  pname = "yi-contrib";
  version = "0.9.0";
  src = /home/bmuk/Code/yi/yi-contrib;
  buildDepends = [
    filepath lens mtl split time transformersBase yi
  ];
  meta = {
    homepage = "http://haskell.org/haskellwiki/Yi";
    description = "Add-ons to Yi, the Haskell-Scriptable Editor";
    license = "GPL";
    platforms = self.ghc.meta.platforms;
  };
})
