{ pkgs ? import <nixpkgs> {} }: {
  shen = with pkgs; stdenv.mkDerivation rec {
    version = "21.1";
    name = "shen-${version}";
    buildInputs = [ sbcl ];
    src = builtins.fetchGit {
      url = "https://github.com/Shen-Language/shen-cl.git";
      ref = "master";
      rev = "ee94f4c87db6c5de26e380cc34487002c259962b";
    };
    kernel = builtins.fetchTarball {
      url = "https://github.com/Shen-Language/shen-sources/releases/download/shen-${version}/ShenOSKernel-${version}.tar.gz";
      sha256 = "0smhc07i4b38nbz5amizxkpk5zdkkpixlaapxj8yfwdgywrv6594";
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
