{ cabal }:

cabal.mkDerivation (self: {
  pname = "Todo";
  version = "0.0.1";
  src = /home/bmuk/Code/todo;
  isLibrary = true;
  isExecutable = true;
  buildDepends = [];
  testDepends = [];
  buildTools = [];
  configureFlags = [];
  meta = {
    homepage = "http://bmuk.io";
    description = "Todo";
    license = "GPL";
    platforms = self.ghc.meta.platforms;
  };
})
