#!/usr/bin/env bash

LLVM_TOOLCHAIN_LIB_DIR=$(llvm-config --libdir)

SOURCES_ROOT="../source/"

LD_FLAGS=""
LD_FLAGS="${LD_FLAGS} -Wl,-rpath ${LLVM_TOOLCHAIN_LIB_DIR}"

CXX_FLAGS=
CXX_FLAGS="${CXX_FLAGS} -fPIC"
CXX_FLAGS="${CXX_FLAGS} -fsanitize-memory-track-origins"

INSTALL_DIR="/bulk/workbench/llvm/6.0/libcxx-msan/"

CC=clang CXX=clang++ \
  cmake \
  -GNinja \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=On \
  -DCMAKE_CXX_FLAGS="${CXX_FLAGS}" \
  -DCMAKE_SHARED_LINKER_FLAGS="${LD_FLAGS}" \
  -DCMAKE_MODULE_LINKER_FLAGS="${LD_FLAGS}" \
  -DLLVM_USE_SANITIZER=Memory \
  -DLLVM_PATH="${SOURCES_ROOT}/llvm" \
  -DLIBCXX_CXX_ABI=libcxxabi \
  -DLIBCXX_CXX_ABI_INCLUDE_PATHS="${SOURCES_ROOT}/libcxxabi/include/" \
  -DLIBCXX_ENABLE_EXCEPTIONS=On \
  -DLIBCXX_ENABLE_RTTI=On \
  -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}" \
  "${SOURCES_ROOT}/libcxx/"

