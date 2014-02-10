source "$pkg_common"

requires=\
(
    'eglibc/cross'
)

configure()
{
    MAKEINFO='/bin/true' \
        "../gcc-$version/configure" $cfg_target_gcc_configure_flags \
        --target="$cfg_target_canonical" \
        --prefix="/" \
        --with-sysroot="$cfg_dir_sysroot" \
        --with-mpfr="$cfg_dir_root" \
        --with-gmp="$cfg_dir_root" \
        --with-mpc="$cfg_dir_root" \
        --disable-libssp \
        --disable-libgomp \
        --disable-libmudflap \
        --disable-nls \
        --disable-multilib \
        --enable-__cxa_atexit \
        --enable-languages=c,c++
}

build()
{
    $cmd_make
}

install()
{
    # Host.
    $cmd_mkdir \
        "$pkg_dir_sysroot" &&

    ln -nfs \
        . \
        "$pkg_dir_sysroot/usr" &&

    $cmd_make \
        DESTDIR="$pkg_dir_host" \
        install &&

    rm -rf \
        "$pkg_dir_host/share" \
        "$pkg_dir_host/include" \
        "$pkg_dir_host/lib/libiberty.a" &&

    # Target.
    $cmd_mkdir \
        "$pkg_dir_target/lib" &&

    $cmd_cp \
        "$pkg_dir_host/$cfg_target_canonical/lib/libgcc_s.so"* \
        "$pkg_dir_host/$cfg_target_canonical/lib/libstdc++.so"* \
        "$pkg_dir_target/lib" &&

    rm -rf \
        "$pkg_dir_target/lib/"*.py &&

    chmod 0755 \
        "$pkg_dir_target/lib/"* &&

    find "$pkg_target_dir/lib". -type f -name '*.so*' | while read f; do
        $cmd_target_strip "$f"
    done
}
