version=\
(
    '9'
)

url=\
(
    "ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/kmod-$version.tar.bz2"
)

md5=\
(
    '29bd0fec976c1664a4abc83f1c7e57ed'
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

host_install()
{
    # Host.
    $cmd_make \
        prefix="$pkg_dir_host" \
        install &&

    $cmd_mkdir \
        "$pkg_dir_host/sbin" &&

    ln -fs \
        "kmod" \
        "$pkg_dir_host/sbin/depmod" &&

    rm -rf \
        "$pkg_dir_host/share"
}
