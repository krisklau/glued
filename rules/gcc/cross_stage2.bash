source "$pkg_common"

requires=\
(
    'eglibc/headers'
)

configure()
{
    MAKEINFO='/bin/true' \
        "../gcc-$version/configure" $cfg_target_gcc_configure_flags \
        --prefix="$cfg_dir_root" \
        --with-sysroot="$cfg_dir_sysroot" \
        --target="$cfg_target_canonical" \
        --host="$cfg_host_canonical" \
        --build="$cfg_host_canonical" \
        --with-mpfr="$cfg_dir_root" \
        --with-gmp="$cfg_dir_root" \
        --with-mpc="$cfg_dir_root" \
        --disable-libssp \
        --disable-libgomp \
        --disable-libmudflap \
        --disable-libquadmath \
        --disable-libatomic \
        --disable-multilib \
        --disable-nls \
        --enable-languages=c
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make \
        prefix="$pkg_dir_host" \
        install &&

    rm -rf \
        "$pkg_dir_host/include" \
        "$pkg_dir_host/share" \
        "$pkg_dir_host/lib/libiberty.a"
}
