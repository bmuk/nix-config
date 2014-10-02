{ cabal, parallel
}:

cabal.mkDerivation (self: {
  pname = "parallel-haskell";
  version = "0.0.1";
  src = /home/bmuk/Code/parallel-haskell;
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    parallel
  ];
  testDepends = [];
  buildTools = [];
  configureFlags = [];
  meta = {
    homepage = "http://bmuk.io";
    description = "Study of Parallelism in Haskell";
    license = "GPL";
    platforms = self.ghc.meta.platforms;
  };
})
