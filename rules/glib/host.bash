source "$pkg_common"

requires=\
(
    'libffi/host'
    'gettext/host'
    'zlib/host'
    'python2/host'
)

configure()
{
    pkg_config_env_host

    "./configure" \
        --prefix="/" \
        --enable-man=no \
        --enable-gtk-doc=no \
        --enable-gtk-doc-html=no \
        --enable-gtk-doc-pdf=no \
        --disable-nls
}

build()
{
    $cmd_make
}

install()
{
    $cmd_make \
        DESTDIR="$pkg_dir_host" \
        install &&

    rm -rf \
        "$pkg_dir_host/share/locale" \
        "$pkg_dir_host/share/gtk-doc" \
        "$pkg_dir_host/share/bash-completion" \
        "$pkg_dir_host/share/gdb"
}
