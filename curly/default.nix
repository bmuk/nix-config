{ cabal, gtk, webkit }:

cabal.mkDerivation (self: {
  pname = "curly";
  version = "0.0.1";
  src = /home/bmuk/Code/curly;
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    gtk webkit
  ];
  testDepends = [];
  buildTools = [];
  configureFlags = [];
  meta = {
    homepage = "http://bmuk.io";
    description = "Reinventing the wheel and writing my own web browser";
    license = "GPL";
    platforms = self.ghc.meta.platforms;
  };
})
