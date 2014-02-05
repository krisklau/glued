source "$pkg_common"

configure()
{
    "../pcre-$version/configure" \
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
    $cmd_make install-strip
}

target_install()
{
    for l in pcre pcrecpp pcreposix; do
        cp -a "$cfg_dir_toolchain_sysroot/usr/lib"/lib$l.so* "$cfg_dir_rootfs"/lib
    done
}
