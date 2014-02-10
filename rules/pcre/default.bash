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
        "$pkg_dir_sysroot/share"
}
