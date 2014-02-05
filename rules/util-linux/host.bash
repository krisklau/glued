source "$pkg_common"

configure()
{
    "../util-linux-$version/configure" \
        --prefix="$cfg_dir_root" \
        --disable-wall \
        --enable-static \
        --disable-shared \
        --without-ncurses \
        --disable-nls
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
        "$pkg_dir_host/share/man" \
        "$pkg_dir_host/include" &&

    # No setuid.
    rm -f \
        "$pkg_dir_host/bin/mount" \
        "$pkg_dir_host/bin/umount"
}
