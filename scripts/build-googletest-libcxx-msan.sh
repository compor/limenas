#!/usr/bin/env bash

SOURCES_ROOT=/bulk/workbench/repos/googletest/

LIBCXX_MSAN_ROOT=/bulk/workbench/llvm/6.0/libcxx-msan/

CXX_FLAGS="-stdlib=libc++"

MSAN_COMPILE_FLAGS=
MSAN_COMPILE_FLAGS="${MSAN_COMPILE_FLAGS} -fsanitize=memory"
MSAN_COMPILE_FLAGS="${MSAN_COMPILE_FLAGS} -I${LIBCXX_MSAN_ROOT}/include"
MSAN_COMPILE_FLAGS="${MSAN_COMPILE_FLAGS} -I${LIBCXX_MSAN_ROOT}/include/c++/v1"

LD_FLAGS=

MSAN_LINKER_FLAGS=
MSAN_LINKER_FLAGS="${MSAN_LINKER_FLAGS} -Wl,-L${LIBCXX_MSAN_ROOT}/lib"
MSAN_LINKER_FLAGS="${MSAN_LINKER_FLAGS} -lc++ -lc++abi"

INSTALL_DIR=/usr/local/gtest-libcxx-msan

CXX=clang++ CC=clang \
  cmake \
  -GNinja \
  -DCMAKE_POLICY_DEFAULT_CMP0022=NEW \
  -DCMAKE_POLICY_DEFAULT_CMP0056=NEW \
  -DCMAKE_POLICY_DEFAULT_CMP0058=NEW \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_CXX_FLAGS="${CXX_FLAGS} ${MSAN_COMPILE_FLAGS}" \
  -DCMAKE_SHARED_LINKER_FLAGS="${LD_FLAGS} ${MSAN_LINKER_FLAGS}" \
  -DCMAKE_EXE_LINKER_FLAGS="${LD_FLAGS} ${MSAN_LINKER_FLAGS}" \
  -DCMAKE_MODULE_LINKER_FLAGS="${LD_FLAGS} ${MSAN_LINKER_FLAGS}" \
  -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}" \
  ${SOURCES_ROOT}
