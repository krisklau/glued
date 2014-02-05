version=\
(
    '0.9'
)

url=\
(
    "http://www.multiprecision.org/mpc/download/mpc-$version.tar.gz"
)

md5=\
(
    '0d6acab8d214bd7d1fbbc593e83dd00d'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'mpfr/host'
)

configure()
{
    ./configure \
        --prefix="$cfg_dir_root" \
        --with-gmp="$cfg_dir_root" \
        --with-mpfr="$cfg_dir_root" \
        --disable-shared \
        --enable-static
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
        "$pkg_dir_host/share"
}
