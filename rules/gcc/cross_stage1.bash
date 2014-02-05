source "$pkg_common"

requires=\
(
    'binutils/cross'
    'mpfr/host'
    'gmp/host'
    'mpc/host'
)

configure()
{
    MAKEINFO='/bin/true' \
        "../gcc-$version/configure" $cfg_target_gcc_configure_flags \
        --target="$cfg_target_canonical" \
        --host="$cfg_host_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_root" \
        --with-mpfr="$cfg_dir_root" \
        --with-gmp="$cfg_dir_root" \
        --with-mpc="$cfg_dir_root" \
        --with-newlib \
        --without-headers \
        --disable-shared \
        --disable-threads \
        --disable-libatomic \
        --disable-libssp \
        --disable-libgomp \
        --disable-libmudflap \
        --disable-libquadmath \
        --disable-multilib \
        --disable-decimal-float \
        --disable-nls \
        --enable-poison-system-directories \
        --enable-target-optspace \
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
