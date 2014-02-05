version=\
(
    '0.25'
)

url=\
(
    "http://pkgconfig.freedesktop.org/releases/pkg-config-$version.tar.gz"
)

md5=\
(
    'a3270bab3f4b69b7dc6dbdacbcae9745'
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
        "$pkg_dir_host/share/man" \
        "$pkg_dir_host/share/doc"
}
