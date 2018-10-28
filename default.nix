{ pkgs ? import <nixpkgs> {} }:
let
  shen-cl = builtins.fromJSON (builtins.readFile ./shen-cl.json);
in {
  shen = with pkgs; stdenv.mkDerivation {
    name = "shen-21.1";
    builder = ./builder.sh;
    src = fetchFromGitHub {
      owner = "Shen-Language";
      repo  = "shen-cl";
      inherit (shen-cl) rev sha256;
    };
    kernel = fetchurl {
      url = "https://github.com/Shen-Language/shen-sources/releases/download/shen-21.1/ShenOSKernel-21.1.tar.gz";
      sha256 = "0sfgsmaxag6gxj7ljw98ayxi7w27ml11bw8rgvpvjr4y52hcl7dp";
    };
    buildInputs = [ sbcl ];
  };
}
