#!/bin/bash
TEMP=$(mktemp -d)
SRC="pcre-8.42"
echo "Using temp directory $TEMP to build $SRC"
(
  cd "$TEMP"
  wget -qN --show-progress "https://ftp.pcre.org/pub/pcre/$SRC.tar.gz"
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
case "${PLATFORM}" in
  Linux*)  OUTPUT=libpcre_linux.a;;
  Darwin*) OUTPUT=libpcre_darwin.a;;
  *)       OUTPUT=libpcre.a
esac
cp "$TEMP/$SRC/.libs/libpcre.a" "$OUTPUT"
echo "Copied static library to $OUTPUT"
rm -rf "$TEMP"
