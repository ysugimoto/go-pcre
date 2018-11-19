#!/bin/bash
TEMP=$(mktemp -d pcre.XXXXXX --tmpdir)
SRC="pcre-8.42"
echo "Using temp directory $TEMP"
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
cp "$TEMP/$SRC/.libs/libpcre.a" ./
echo "Copied static library to libpcre.a"
rm -rf "$TEMP"
