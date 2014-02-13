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
    $cmd_make \
        distclean > /dev/null 2>&1

    pkg_config_env_host

    "./configure" \
        --prefix="" \
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
        "$pkg_dir_host/share/gdb" &&

    find "$pkg_dir_host/lib/gio/modules" -type f -name '*.la' | while read f; do
        libtool_replace_libdir "$f" "/lib/gio/modules" "$cfg_dir_root/lib/gio/modules"
    done &&

    find "$pkg_dir_host/lib" -type f -name '*.la' | while read f; do
        libtool_replace_libdir "$f" "/lib" "$cfg_dir_root/lib"
    done
}
