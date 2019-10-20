{ pkgs ? import <nixpkgs> {} }: {
  shen = with pkgs; stdenv.mkDerivation rec {
    version = "3.0.2";
    name = "shen-${version}";
    buildInputs = [ sbcl ];
    src = builtins.fetchTarball {
      url = "https://github.com/Shen-Language/shen-cl/releases/download/v${version}/shen-cl-v${version}-sources.tar.gz";
      sha256 = "0zp1w66mnqcqhbxh6q8j7s5x6fbgyhs3vhddvy9v8d0bqc94yjxc";
    };
    kernel =
      let
        kernel-version = "22.2";
      in
        builtins.fetchTarball {
          url = "https://github.com/Shen-Language/shen-sources/releases/download/shen-${kernel-version}/ShenOSKernel-${kernel-version}.tar.gz";
          sha256 = "1nvllxvzrws3gwjc1zkmrnd6vy4r8p4s6bx2jr03pifmkp55rk4c";
        };
    configurePhase = ''
      ln -s $kernel kernel
    '';
    buildFlags = [ "build-sbcl" ];
    doCheck = true;
    checkTarget = "test-sbcl";
    installPhase = ''
      mkdir -p $out/bin
      cp bin/sbcl/shen $out/bin
    '';
  };
}
