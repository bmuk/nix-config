{ cabal, alex, binary, Cabal, cautiousFile, concreteTyperep
, dataDefault, derive, Diff, dlist, dyre, filepath, fingertree
, glib, gtk, hashable, hint, HUnit, lens, mtl, pango, parsec
, pointedlist, QuickCheck, random, regexBase, regexTdfa, safe
, semigroups, split, tagged, tasty, tastyHunit, tastyQuickcheck
, text, time, transformersBase, unixCompat, unorderedContainers
, utf8String, vty, xdgBasedir, wordTrie, ooPrototypes, yiLanguage
}:

cabal.mkDerivation (self: {
  pname = "yi";
  version = "0.9.1";
  src = /home/bmuk/Code/yi/yi;
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    binary Cabal cautiousFile concreteTyperep dataDefault derive Diff
    dlist dyre filepath fingertree glib gtk hashable hint lens mtl
    pango parsec pointedlist QuickCheck random regexBase regexTdfa safe
    semigroups split tagged text time transformersBase unixCompat
    unorderedContainers utf8String vty xdgBasedir wordTrie ooPrototypes
    yiLanguage
  ];
  testDepends = [
    filepath HUnit lens QuickCheck tasty tastyHunit tastyQuickcheck semigroups
  ];
  buildTools = [ alex ];
  configureFlags = [ "-fpango" "--enable-executable-profiling" ];

  # https://ghc.haskell.org/trac/ghc/ticket/9170
  noHaddock = self.ghc.version == "7.6.3";

  postInstall = ''
    mv $out/bin/yi $out/bin/.yi-wrapped
    cat - > $out/bin/yi <<EOF
    #! ${self.stdenv.shell}
    # Trailing : is necessary for it to pick up Prelude &c.
    export GHC_PACKAGE_PATH=$(${self.ghc.GHCGetPackages} ${self.ghc.version} \
                              | sed 's/-package-db\ //g' \
                              | sed 's/^\ //g' \
                              | sed 's/\ /:/g')\
    :$out/lib/ghc-${self.ghc.version}/package.conf.d/yi-$version.installedconf:
    eval exec $out/bin/.yi-wrapped "\$@"
    EOF
    chmod +x $out/bin/yi
  '';

  meta = {
    homepage = "http://haskell.org/haskellwiki/Yi";
    description = "The Haskell-Scriptable Editor";
    license = "GPL";
    platforms = self.ghc.meta.platforms;
  };
})
