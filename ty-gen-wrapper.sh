#!/bin/bash

# Usage
#   ty-gen-wrapper <lib-name>

dir_name="$1"-cmake
in_file="$dir_name/cmake/$1Config.cmake.in"

mkdir -p "$dir_name"
mkdir -p "$dir_name/cmake"

touch "$in_file"
echo "@PACKAGE_INIT@" > "$in_file"
echo "include(\"\${CMAKE_CURRENT_LIST_DIR}/$1Targets.cmake\")" >> "$in_file"

sed "s/\[\[TY-LIB-NAME\]\]/$1/g" ty-wrapper-lists-template.txt > "$dir_name"/CMakeLists.txt

