#!/bin/bash
TEMP=$(mktemp -d)
SRC="pcre-8.45"
echo "Using temp directory $TEMP to build $SRC"
(
  cd "$TEMP"
  wget -qN --show-progress -O ${SRC}.tar.gz "https://ja.osdn.net/frs/g_redir.php?m=rwthaachen&f=pcre%2Fpcre%2F8.45%2F${SRC}.tar.gz"
  tar -xf "$SRC.tar.gz"
  (
    cd "$SRC"
    ./configure \
      --enable-jit \
      --enable-utf \
      --disable-shared \
      --disable-cpp \
      --enable-newline-is-any \
      --with-match-limit=500000 \
      --with-match-limit-recursion=50000
    make
  )
)
PLATFORM="$(uname -s)"
ARCH="$(uname -m)"

case "${PLATFORM}_${ARCH}" in
  Linux_x86_64*)  OUTPUT=libpcre_linux_x86_64.a;;
  Darwin_x86_64*) OUTPUT=libpcre_darwin_x86_64.a;;
  Darwin_arm64*) OUTPUT=libpcre_darwin_arm64.a;;
  *)       OUTPUT=libpcre.a
esac
cp "$TEMP/$SRC/.libs/libpcre.a" "$OUTPUT"
echo "Copied static library to $OUTPUT"
rm -rf "$TEMP"
