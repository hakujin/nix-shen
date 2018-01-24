{ pkgs ? import <nixpkgs> {} }:
let
  shen-cl = builtins.fromJSON (builtins.readFile ./shen-cl.json);
in {
  shen = with pkgs; stdenv.mkDerivation {
    name = "shen-20.1";
    builder = ./builder.sh;
    src = fetchFromGitHub {
      owner = "Shen-Language";
      repo  = "shen-cl";
      inherit (shen-cl) rev sha256;
    };
    kernel = fetchurl {
      url = "https://github.com/Shen-Language/shen-sources/releases/download/shen-20.1/ShenOSKernel-20.1.tar.gz";
      sha256 = "04zjja381ibqm21cj5m5rq8c0gp9w7k33k89dpwcngkdmc4n38y0";
    };
    buildInputs = [ sbcl ];
  };
}
