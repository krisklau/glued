version=\
(
    '4.1.0'
)

url=\
(
    "http://ftp.gnu.org/gnu/gawk/gawk-$version.tar.xz"
)

md5=\
(
    'b18992ff8faf3217dab55d2d0aa7d707'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'readline/host'
    'mpfr/host'
)

configure()
{
    ./configure \
        --prefix="$cfg_dir_root" \
        --disable-nls \
        --enable-static \
        --disable-shared \
        --with-mpfr="$cfg_dir_root"
}

build()
{
    $cmd_make
}

install()
{
    $cmd_make \
        prefix="$pkg_dir_host" \
        install &&

    rm -rf \
        "$pkg_dir_host/share/info" \
        "$pkg_dir_host/share/man"
}