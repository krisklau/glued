source "$pkg_common"

configure()
{
    "../pcre-$version/configure" \
        --prefix=""
}

build()
{
    $cmd_make
}

install()
{
    $cmd_make \
        prefix="$pkg_dir_host" \
        install-strip &&

    rm -rf \
        "$pkg_dir_host/share" &&

    find "$pkg_dir_host/lib" -type f -name '*.la' | while read f; do
        libtool_replace_libdir "$f" "/lib" "$cfg_dir_root/lib"
    done
}
