version=\
(
    '5.1'
)

url=\
(
    "http://ftp.gnu.org/gnu/texinfo/texinfo-$version.tar.gz"
)

md5=\
(
    '54e250014fe698fb4832016158747c03'
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
        "$pkg_dir_host/share/info" \
        "$pkg_dir_host/share/man"
}
