let pkgs = import <nixpkgs> {};
in
{ stdenv ? pkgs.stdenv, python ? pkgs.python, python3 ? pkgs.python3 }: 
stdenv.mkDerivation {
  name = "python-dev";
  version = "0.0.1";
  src = "./.";
  buildInputs = [ python python3 ];
  shellHook = ''
    pushd /home/bmuk/annex/School/programming/
  '';
}
