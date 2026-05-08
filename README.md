# About

`ty-vendor` is a simple collection of bash scripts that configure, build, and install dependencies into a folder that can easily be used with CMake's `find_package`.

# Install

1. Copy the scripts into a `vendor` folder.

# Usage

### ty-build-all
*For configuring, building, and installing all dependencies*
1. Add your dependencies to the bottom of `ty-build-all.sh`. There are some example dependencies already there.
2. From `vendor`, run `./ty-build-all.sh <build-config e.g. Debug>`.
3. Add the `ty-install-<build-config>` folder that is generated to your CMake project's `CMAKE_PREFIX_PATHS`. Packages can now be used with `find_package`, and all necessary `include` paths will be added when a dependency is linked.

### ty-gen-wrapper
*For wrapping a header only non-CMake library in an `INTERFACE` CMake library*
1. Run `./ty-gen-wrapper.sh <lib-name>` from `vendor`.
2. Add the library as a sub-folder of the `<lib-name>-cmake` folder that was generated.
3. To wrap a static library instead, within the generated `CMakeLists.txt` simply change:
   1. `INTERFACE` to `STATIC` in the `add_library` command
   2. Add all necessary sources to the `add_library` command
   3. `INTERFACE` to `PUBLIC` in the `target_include_directories` command (or whatever is appropriate)
