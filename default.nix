{ stdenv, fetchzip, sbcl }:
let version = "S39.1";
in stdenv.mkDerivation {
  pname = "shen-sbcl";
  inherit version;
  nativeBuildInputs = [ sbcl ];
  src = fetchzip {
    url = "https://www.shenlanguage.org/Download/${version}.zip";
    sha256 = "sha256-reN9avgYGYCMiA5BeHLhRK51liKF2ctqIgxf+4IWjVY=";
  };
  dontStrip = true; # necessary to prevent runtime errors with sbcl
  dontConfigure = true;
  buildPhase = ''
    sbcl --noinform --no-sysinit --no-userinit --load install.lsp
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp sbcl-shen.exe $out/bin/shen-sbcl
  '';
}
