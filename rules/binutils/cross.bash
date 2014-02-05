version=\
(
    '2.22'
)

url=\
(
    "http://mirrors.kernel.org/gnu/binutils/binutils-$version.tar.bz2"
)

md5=\
(
    'ee0f10756c84979622b992a4a61ea3f5'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'mpfr/host'
    'mpc/host'
)

configure()
{
    "../binutils-$version/configure" $extra_flags \
        --prefix="$cfg_dir_root" \
        --target="$cfg_target_canonical" \
        --host="$cfg_host_canonical" \
        --build="$cfg_host_canonical" \
        --with-sysroot="$cfg_dir_sysroot" \
        --with-mpfr="$cfg_dir_root" \
        --with-gmp="$cfg_dir_root" \
        --with-mpc="$cfg_dir_root" \
        --disable-nls \
        --disable-werror \
        --disable-multilib
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
        "$pkg_dir_host/share" \
        "$pkg_dir_host/lib"
}
