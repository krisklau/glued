source "$pkg_common"

configure()
{
    "../libffi-$version/configure" \
        --prefix="$cfg_dir_root"
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
    #sed 's/Libs: /Libs: -L${libdir} /g' "$cfg_dir_toolchain/lib/pkgconfig/libffi.pc" -i
}
