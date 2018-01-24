source $stdenv/setup

# setup
mkdir build
mkdir -p $out/bin
tar xvfz $kernel
mv ShenOSKernel-20.1 build/kernel
cp -r $src/* build

# building
cd build
make build-sbcl
cp bin/sbcl/shen $out/bin
