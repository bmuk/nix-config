let pkgs = import <nixpkgs> {};
in
{ stdenv ? pkgs.stdenv, python ? pkgs.python }: 
stdenv.mkDerivation {
  name = "python-dev";
  version = "0.0.1";
  src = "./.";
  buildInputs = [ python ];
}
