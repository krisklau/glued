source "$pkg_common"

configure()
{
    "../libffi-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="/" \
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
        "$pkg_dir_sysroot/share"
}
