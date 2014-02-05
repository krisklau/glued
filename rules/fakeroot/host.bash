version=\
(
    '1.12.2'
)

url=\
(
    "http://www.lsts.pt/glued/fakeroot_$version.tar.gz"
)

md5=\
(
    '1eb7d972a19159035892e7d132602726'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    "../fakeroot-$version/configure" \
        --prefix="$cfg_dir_root" \
        --disable-static \
        --enable-shared \
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
