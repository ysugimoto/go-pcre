# go-pcre

This is a Go language package providing support for
Perl Compatible Regular Expressions (PCRE).

forked from https://github.com/rubrikinc/go-pcre and support M1 mac (arm64).

## Installation

```
$ go get github.com/ysugimoto/go-pcre
```

## Usage

Go programs that depend on this package should import
this package as follows to allow automatic downloading:

```go
import "github.com/ysugimoto/go-pcre"
```

## Upgrading

To upgrade static libraries, run the following script on Linux and Mac to create the necessary static libs.

   ./build_lib.sh

The static library will be either `libpcre_darwin_x86_64.a`, `libpcre_darwin_arm64.a`, or `libpcre_linux_x86_64.a`

The library is compiled with the following options:
```
--enable-jit
--enable-utf
--disable-shared
--disable-cpp
--enable-newline-is-any
--with-match-limit=500000
--with-match-limit-recursion=50000
```

## History

This is a clone of
[golang-pkg-pcre](http://git.enyo.de/fw/debian/golang-pkg-pcre.git)
by Florian Weimer, which has been placed on Github by Glenn Brown,
so it can be fetched automatically by Go's package installer.

Glenn Brown added `FindIndex()` and `ReplaceAll()`
to mimic functions in Go's default regexp package.

Mathieu Payeur Levallois added `Matcher.ExtractString()`.

Malte Nuhn added `GroupIndices()` to retrieve positions of a matching group.

Chandra Sekar S added `Index()` and stopped invoking `Match()` twice in `FindIndex()`.

Misakwa added support for `pkg-config` to locate `libpcre`.

Yann Ramin added `ReplaceAllString()` and changed `Compile()` return type to `error`.

Nikolay Sivko modified `name2index()` to return error instead of panic.

Harry Waye exposed raw `pcre_exec`.

Hazzadous added partial match support.

Pavel Gryaznov added support for JIT compilation.
