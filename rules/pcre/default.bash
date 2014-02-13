source "$pkg_common"

configure()
{
    "../pcre-$version/configure" \
        --prefix="$pkg_dir_sysroot" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical"
}

build()
{
    $cmd_make
}

install()
{
    # Host.
    $cmd_make \
        install &&

    rm -rf \
        "$pkg_dir_sysroot/share" &&

    find "$pkg_dir_sysroot/lib" -type f -name '*.la' | while read f; do
        libtool_replace_libdir "$f" "$pkg_dir_sysroot/lib" "$cfg_dir_sysroot/lib"
    done
}
