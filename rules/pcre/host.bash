source "$pkg_common"

configure()
{
    "../pcre-$version/configure" \
        --prefix="$cfg_dir_host"
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
        "$pkg_dir_host/share"
}
