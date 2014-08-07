#!/bin/sh
set -e
set -x
if test "x$1" = "x--help" ; then
  cat << EOF
Usage: $0 {user}/{repo} {neovim-branch}
EOF
  exit
fi

rm -rf 32
rm -rf bin etc include lib share
rm -rf neovim

git clone --depth=1 -b${2:-master} git://github.com/${1:-neovim/neovim} neovim

PREFIX="$(realpath "$(dirname "$0")")"

pushd neovim

patch -p1 << EOF
diff --git a/third-party/CMakeLists.txt b/third-party/CMakeLists.txt
--- a/third-party/CMakeLists.txt
+++ b/third-party/CMakeLists.txt
@@ -7,9 +7,9 @@ if(NOT DEPS_DIR)
   set(DEPS_DIR \${PARENT_DIR}/.deps)
 endif()
 
-set(DEPS_INSTALL_DIR "\${DEPS_DIR}/usr")
-set(DEPS_BIN_DIR "\${DEPS_DIR}/usr/bin")
-set(DEPS_LIB_DIR "\${DEPS_DIR}/usr/lib")
+set(DEPS_INSTALL_DIR "$PREFIX")
+set(DEPS_BIN_DIR "$PREFIX/bin")
+set(DEPS_LIB_DIR "$PREFIX/lib")
 set(DEPS_BUILD_DIR "\${DEPS_DIR}/build")
 set(DEPS_DOWNLOAD_DIR "\${DEPS_BUILD_DIR}/downloads")
 
EOF
make deps

rm -rf build
rm -rf .deps/build/{src,third-party,tmp}

mkdir _bin
cat > _bin/gcc << EOF
#!/bin/sh
/usr/bin/gcc -m32 "\$@"
EOF
chmod +x _bin/gcc

export PATH="$(realpath _bin):${PATH}"
export CC="$(realpath _bin/gcc)"

patch -p1 << EOF
diff --git a/third-party/CMakeLists.txt b/third-party/CMakeLists.txt
--- a/third-party/CMakeLists.txt
+++ b/third-party/CMakeLists.txt
@@ -7,9 +7,9 @@
   set(DEPS_DIR \${PARENT_DIR}/.deps)
 endif()
 
-set(DEPS_INSTALL_DIR "$PREFIX")
-set(DEPS_BIN_DIR "$PREFIX/bin")
-set(DEPS_LIB_DIR "$PREFIX/lib")
+set(DEPS_INSTALL_DIR "$PREFIX/32")
+set(DEPS_BIN_DIR "$PREFIX/32/bin")
+set(DEPS_LIB_DIR "$PREFIX/32/lib")
 set(DEPS_BUILD_DIR "\${DEPS_DIR}/build")
 set(DEPS_DOWNLOAD_DIR "\${DEPS_BUILD_DIR}/downloads")
 
EOF
make deps

popd

rm -rf neovim

cp color_terminal.lua share/lua/*/busted/output
cp color_terminal.lua 32/share/lua/*/busted/output

git add .
