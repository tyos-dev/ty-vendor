#!/bin/bash

build_type="$1"
build_dir="ty-build-$build_type"
install_dir="ty-install-$build_type"

mkdir -p "$build_dir" || exit
mkdir -p "$install_dir" || exit

build-project() {
  local loc_build_dir="$build_dir/$1"
  local loc_install_dir="$install_dir/$1"

  mkdir -p "$loc_build_dir" || exit

  # Use an isolated install directory (e.g. <install-prefix>/<lib-name> instead of <install-prefix>) so that clients
  # have to explicitly link to the dependency they are using for includes to work. Otherwise, if a client links to
  # just one dependency and the general include path is <install-prefix>/include, all of the other libs will be inside
  # that include folder and the client will get them for free.
  cmake -S "$1" -B "$loc_build_dir" -DCMAKE_BUILD_TYPE="$build_type" -DCMAKE_INSTALL_PREFIX="$loc_install_dir" "${@:2}" || exit
  cmake --build "$loc_build_dir" || exit
  cmake --install "$loc_build_dir" || exit

  # Lib name should be the same as the top level folder name to support find_package
  #
  # Example:
  # googletest/lib/cmake/GTest -> GTest/lib/cmake/GTest
  #
  local cmake_path="$loc_install_dir/lib/cmake"
  if [ -d "$cmake_path" ]; then
    local lib_name=$(ls "$loc_install_dir"/lib/cmake)
    if [ "$1" != "$lib_name" ]; then
      local lib_path="$install_dir/$lib_name"
      [ -d "$lib_path" ] && rm -rf "$lib_path"
      mv "$loc_install_dir" "$lib_path" || exit
    fi
  fi
}

# Freetype
build-project freetype

# GLFW
build-project glfw

# GLM
build-project glm -DGLM_BUILD_INSTALL=ON

# GLTF
build-project gltf-cmake

# Google Test
build-project googletest

# Google Benchmark
# TODO: make sure we are using a local version of Google Test instead of whatever it is downloading
build-project benchmark -DBENCHMARK_ENABLE_GTEST_TESTS=OFF -DBENCHMARK_DOWNLOAD_DEPENDENCIES=ON

# STB
build-project stb-cmake