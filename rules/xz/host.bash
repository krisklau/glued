version=\
(
    '5.0.4'
)

url=\
(
    "http://tukaani.org/xz/xz-$version.tar.bz2"
)

md5=\
(
    '741cd3a5f64b23b7bac56ec5b2258715'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    ./configure \
        --prefix="$cfg_dir_root" \
        --disable-nls \
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
        prefix="$pkg_dir_host" install &&

    rm -rf \
        "$pkg_dir_host/share" \
        "$pkg_dir_host/include"
}
