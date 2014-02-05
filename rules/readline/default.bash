source "$pkg_common"

configure()
{
    "../readline-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}

target_install()
{
    for lib in history readline; do
        install "$cfg_dir_toolchain_sysroot/usr/lib/lib$lib.so"* "$cfg_dir_rootfs/usr/lib"
        $cmd_target_strip --strip-unneeded "$cfg_dir_rootfs/usr/lib/lib$lib.so"*
    done
}
