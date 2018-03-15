{ pkgs ? import <nixpkgs> {} }:
let
  shen-cl = builtins.fromJSON (builtins.readFile ./shen-cl.json);
in {
  shen = with pkgs; stdenv.mkDerivation {
    name = "shen-21.0";
    builder = ./builder.sh;
    src = fetchFromGitHub {
      owner = "Shen-Language";
      repo  = "shen-cl";
      inherit (shen-cl) rev sha256;
    };
    kernel = fetchurl {
      url = "https://github.com/Shen-Language/shen-sources/releases/download/shen-21.0/ShenOSKernel-21.0.tar.gz";
      sha256 = "1m09fjs201y8hzfyalllnmrgw4lhd2cjs7l75860iy0k6pgzwd3h";
    };
    buildInputs = [ sbcl ];
  };
}
