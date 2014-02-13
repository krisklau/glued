source "$pkg_common"

configure()
{
    "../libffi-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="" \
        --disable-static \
        --enable-shared
}

build()
{
    $cmd_make
}

install()
{
    # Host.
    $cmd_make \
        DESTDIR="$pkg_dir_sysroot" \
        install &&

    rm -rf \
        "$pkg_dir_sysroot/share" &&

    find "$pkg_dir_sysroot/lib" -type f -name '*.la' | while read f; do
        libtool_replace_libdir "$f" "/lib" "$cfg_dir_sysroot/lib"
    done
}
