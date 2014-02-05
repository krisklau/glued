version=\
(
    '1.22.1'
)

url=\
(
    "http://busybox.net/downloads/busybox-$version.tar.bz2"
)

md5=\
(
    '337d1a15ab1cb1d4ed423168b1eb7d7e'
)

post_unpack()
{
    patches=$(ls "$pkg_dir"/patches/*.patch)

    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

configure()
{
    $cmd_cp \
        "$pkg_dir/config" \
        .config &&

    yes '' | $cmd_make \
        CROSS_COMPILE="$cfg_target_canonical"- \
        oldconfig
}

build()
{
    $cmd_make \
        CROSS_COMPILE="$cfg_target_canonical"-
}

target_install()
{
    # Host.
    $cmd_mkdir \
        "$pkg_dir_sysroot" &&

    $cmd_make \
        CROSS_COMPILE="$cfg_target_canonical"- \
        CONFIG_PREFIX="$pkg_dir_sysroot" \
        install &&

    # Target
    $cmd_cp \
        "$pkg_dir_sysroot/"* \
        "$pkg_dir_target" &&

    $cmd_cp \
        "$pkg_dir/fs/"* \
        "$pkg_dir_target"
}
