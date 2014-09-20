{ cabal, binary, dataDefault, derive, ghcMod, lens, network
, PastePipe, split, yi, yiLanguage, ...
}:

cabal.mkDerivation (self: {
  pname = "yi-haskell-utils";
  version = "0.1.0.0";
  src = /home/bmuk/Code/yi-haskell-utils;
  buildDepends = [
    binary dataDefault derive ghcMod lens network PastePipe split yi
    yiLanguage
  ];
  meta = {
    homepage = "https://github.com/Fuuzetsu/yi-haskell-utils";
    description = "Collection of functions for working with Haskell in Yi";
    license = self.stdenv.lib.licenses.gpl3;
    platforms = self.ghc.meta.platforms;
  };
})
