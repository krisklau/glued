version=\
(
    '1.7.0'
)

url=\
(
    "http://wiki.qemu.org/download/qemu-$version.tar.bz2"
)

md5=\
(
    '32893941d40d052a5e649efcf06aca06'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'pcre/host'
    'glib/host'
    'python2/host'
)

configure()
{
    pkg_config_env_host

    "../qemu-$version/configure" \
        --prefix="/" \
        --disable-xen \
        --disable-docs \
        --disable-system \
        --disable-kvm \
        --disable-bluez \
        --disable-curses \
        --extra-cflags="-I$cfg_dir_root/include" \
        --extra-ldflags="-L$cfg_dir_root/lib"
}

build()
{
    $cmd_make
}

install()
{
    $cmd_make \
        DESTDIR="$pkg_dir_host" \
        install
}
