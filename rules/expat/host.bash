source "$pkg_common"

configure()
{
    $cmd_make \
        distclean > /dev/null 2>&1

    "../expat-$version/configure" \
        --enable-static \
        --enable-shared
}

build()
{
    $cmd_make
}

install()
{
    $cmd_make \
        prefix="$pkg_dir_host" \
        install &&

    rm -rf \
        "$pkg_dir_host/man" \
        "$pkg_dir_host/share"
}
