version=\
(
    '3.1.2'
)

url=\
(
    "http://ftp.gnu.org/gnu/mpfr/mpfr-$version.tar.bz2"
)

md5=\
(
    'ee2c3ac63bf0c2359bf08fc3ee094c19'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'gmp/host'
)

configure()
{
    ./configure \
        --prefix="$cfg_dir_root" \
        --with-gmp="$cfg_dir_root" \
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
