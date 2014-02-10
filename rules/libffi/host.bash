source "$pkg_common"

configure()
{
    "../libffi-$version/configure" \
        --prefix='/'
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
        "$pkg_dir_host/share"
}
