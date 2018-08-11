# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

# Collection of sources required to build LCIOWrapBuilder
sources = [
    "https://github.com/jstrube/LCIOWrapBuilder.git" =>
    "451f42e9b3daf41156db502ee45ee8884b77efd2",

    "https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.0-linux-x86_64.tar.gz" =>
    "bea4570d7358016d8ed29d2c15787dbefaea3e746c570763e7ad6040f17831f3",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
tar xzf LCIOBuilder.v2.12.1.x86_64-linux-gnu.tar.gz
tar xzf libcxxwrap-julia-0.7.v0.3.1.x86_64-linux-gnu.tar.gz
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$prefix -DCMAKE_TOOLCHAIN_FILE=/opt/$target/$target.toolchain -DJulia_ROOT=/workspace/srcdir/julia-1.0.0/ ../LCIOWrapBuilder/
make && make install

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:x86_64, :glibc)
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "liblciowrap", :l_lciowrap)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    "https://github.com/JuliaInterop/libcxxwrap-julia/releases/download/v0.3.1/build_libcxxwrap-julia-0.7.v0.3.1.jl",
    "https://github.com/jstrube/LCIOBuilder/releases/download/v2.00.01/build_LCIOBuilder.v2.12.1.jl"
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, "LCIOWrapBuilder", sources, script, platforms, products, dependencies)

