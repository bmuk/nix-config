{ cabal, alex, happy, yesodBin, yesod
}:

cabal.mkDerivation (self: {
  pname = "Blog";
  version = "0.0.1";
  src = /home/bmuk/Code/blog;
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    yesod
  ];
  testDepends = [];
  buildTools = [];
  configureFlags = [];
  meta = {
    homepage = "http://bmuk.io";
    description = "My personal blog.";
    license = "GPL";
    platforms = self.ghc.meta.platforms;
  };
})