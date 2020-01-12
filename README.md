# LCIOWrapBuilder
[![Build Status](https://travis-ci.com/jstrube/LCIOWrapBuilder.svg?branch=master)](https://travis-ci.com/jstrube/LCIOWrapBuilder)

Code to wrap LCIO in Julia

## How to build

- Check out LCIO from https://github.com/iLCSoft/LCIO and build:
    ``` 
    cd LCIO
    mkdir build && cd build
    cmake ..
    make -j4 && make install
    export LCIO_DIR=$(pwd)
    cd ../..
    ```
- Check out libcxxwrap-julia from https://github.com/JuliaInterop/libcxxwrap-julia and build:
    ```
    cd libcxxwrap-julia
    mkdir build && cd build
    export PATH=/path/to/julia-from-source:$PATH
    cmake ..
    make -j4
    export JLCXX_DIR=$(pwd) # for CxxWrap
    export JlCxx_DIR=$(pwd) # for CMake
    cd ../..
    ```
- Check out this package and build
    ```
    cd LCIOWrapBuilder
    mkdir build && cd build
    cmake ..
    make -j4
    export LCIOJL_DIR=$(pwd)
    ```
- start julia
    ```
    ]
    add CxxWrap#master
    build CxxWrap
    add LCIO#master
    build LCIO
    test CxxWrap
    test LCIO
    ```
