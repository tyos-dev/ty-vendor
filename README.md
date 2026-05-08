# About

`ty-vendor` is a simple collection of bash scripts that configure, build, and install dependencies into a folder that can easily be used with CMake's `find_package`.

# Usage

Copy the scripts into a `vendor` folder. Add your dependencies to the bottom of `ty-build-all.sh`. There are some example dependencies already there. Then, `cd` into the `vendor` folder and run `./ty-build-all.sh <build-config e.g. Debug>`. Finally, add the `ty-install-<build-config>` folder that is generated to your CMake project's `CMAKE_PREFIX_PATHS`. Packages can now be used with `find_package`, and all necessary `include` paths will be added when a dependency is linked (header only or otherwise).

To wrap a header only library in an `INTERFACE` CMake library, first run `./ty-gen-wrapper.sh <lib-name>` in `vendor`. Then, add the library as a sub-folder of the `<lib-name>-cmake` folder that was generated. 

