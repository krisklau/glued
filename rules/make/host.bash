version=\
(
    '3.82'
)

url=\
(
    "http://ftp.gnu.org/gnu/make/make-$version.tar.bz2"
)

md5=\
(
    '1a11100f3c63fcf5753818e59d63088f'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    ./configure \
        --prefix="$cfg_dir_root" \
        --disable-shared \
        --enable-static \
        --disable-nls
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
