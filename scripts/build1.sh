#!/bin/bash

LLVM_TOOLCHAIN_LIB_DIR=$(llvm-config --libdir)

LD_FLAGS=""
LD_FLAGS="${LD_FLAGS} -Wl,-L ${LLVM_TOOLCHAIN_LIB_DIR}"
LD_FLAGS="${LD_FLAGS} -Wl,-rpath-link ${LLVM_TOOLCHAIN_LIB_DIR}"
LD_FLAGS="${LD_FLAGS} -lc++ -lc++abi"

CXX_FLAGS=""
CXX_FLAGS="${CXX_FLAGS} -pthread"
CXX_FLAGS="${CXX_FLAGS} -stdlib=libc++"

INSTALL_DIR=/bulk/workbench/llvm/6.0/toolchain1/

CC=clang CXX=clang++ \
  cmake \
  -GNinja \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=On \
  -DBUILD_SHARED_LIBS=On \
  -DLLVM_ENABLE_LIBCXX=On \
  -DLLVM_ENABLE_ASSERTIONS=On \
  -DLLVM_TARGETS_TO_BUILD="X86" \
  -DLLVM_ENABLE_SPHINX=Off \
  -DLLVM_ENABLE_THREADS=On \
  -DLLVM_INSTALL_UTILS=On \
  -DLIBCXX_ENABLE_EXCEPTIONS=On \
  -DLIBCXX_ENABLE_RTTI=On \
  -DCMAKE_BUILD_TYPE=Debug \
  -DCMAKE_CXX_FLAGS="${CXX_FLAGS}" \
  -DCMAKE_SHARED_LINKER_FLAGS="${LD_FLAGS}" \
  -DCMAKE_MODULE_LINKER_FLAGS="${LD_FLAGS}" \
  -DCMAKE_EXE_LINKER_FLAGS="${LD_FLAGS}" \
  -DCMAKE_POLICY_DEFAULT_CMP0056=NEW \
  -DCMAKE_POLICY_DEFAULT_CMP0058=NEW \
  -DLLVM_ENABLE_CXX1Y=On \
  -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}" \
  -DLLVM_EXTERNAL_CLANG_SOURCE_DIR="${1}/../clang/" \
  -DLLVM_ENABLE_PROJECTS="clang;libcxx;libcxxabi;compiler-rt;lld" \
  -DLLVM_OPTIMIZED_TABLEGEN=On \
  -DLLVM_CCACHE_BUILD=On \
  "${1}"

