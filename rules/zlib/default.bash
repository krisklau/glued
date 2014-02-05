source "$pkg_common"

configure()
{
    $cmd_make distclean > /dev/null 2>&1

    CC="$cmd_target_cc" \
        ./configure \
        --prefix="/" \
        --shared
}

build()
{
    $cmd_make -j1
}

install()
{
    # Host.
    $cmd_make \
        prefix="$pkg_dir_sysroot" \
        -j1 \
        install &&

    rm -rf \
        "$pkg_dir_sysroot/share" &&

    # Target.
    $cmd_mkdir \
        "$pkg_dir_target/lib" &&

    $cmd_cp \
        libz.so* \
        "$pkg_dir_target/lib" &&

    $cmd_target_strip \
        "$pkg_dir_target/lib/libz.so"*
}
