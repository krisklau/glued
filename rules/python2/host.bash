source "$pkg_common"

configure()
{
    "../Python-$version/configure" \
        --prefix="$cfg_dir_root"
}

# Warning: parallel builds are not supported.
build()
{
    $cmd_make_single \
        clean &&

    $cmd_make_single
}

install()
{
    $cmd_make_single \
        prefix="$pkg_dir_host" \
        install &&

    rm -rf \
        "$pkg_dir_host/share"
}
