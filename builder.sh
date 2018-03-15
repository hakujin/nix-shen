source $stdenv/setup

# setup
mkdir build
mkdir -p $out/bin
tar xvfz $kernel
mv ShenOSKernel-21.0 build/kernel
cp -r $src/* build

# building
cd build
make build-sbcl
cp bin/sbcl/shen $out/bin
