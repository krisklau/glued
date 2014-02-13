version=\
(
    '1.41.9'
)

url=\
(
    "http://downloads.sourceforge.net/e2fsprogs/e2fsprogs-$version.tar.gz"
)

md5=\
(
    '52f60a9e19a02f142f5546f1b5681927'
)

configure()
{
    export CC="$cmd_target_cc"
    export CROSS_COMPILE="$cfg_target_canonical"
    "../e2fsprogs-$version/configure" \
        --prefix="" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --disable-nls
}

build()
{
    $cmd_make
}

host_install()
{
    # Host.
    $cmd_make \
        prefix="$pkg_dir_sysroot" \
        install &&

    rm -rf \
        "$pkg_dir_sysroot/share" &&

    # Target.
    $cmd_mkdir \
        "$pkg_dir_target/sbin" &&

    for p in e2fsck mke2fs tune2fs; do
        $cmd_target_strip \
            "$pkg_dir_sysroot/sbin/$p" -o "$pkg_dir_target/sbin/$p"
    done &&

    for p in 2 3 4; do
        ln -nfs mke2fs \
            "$pkg_dir_target/sbin/mkfs.ext$p"
        ln -nfs e2fsck \
            "$pkg_dir_target/sbin/fsck.ext$p"
    done
}
