version=\
(
    '2014.01'
)

url=\
(
    "ftp://ftp.denx.de/pub/u-boot/u-boot-$version.tar.bz2"
)

md5=\
(
    'e531307578f6d32a7ccb1d04f1e08cbc'
)

post_unpack()
{
    patches=$(ls "$pkg_dir/patches-$version/"*.patch\
	"$cfg_dir_system/patches/u-boot/patches-${version}/"*.patch 2>/dev/null)
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

configure()
{
    $cmd_make \
        ARCH="$cfg_target_uboot_arch" \
        CROSS_COMPILE="$cfg_target_canonical"- \
        "$cfg_target_uboot_config"
}

build()
{
    $cmd_make \
        ARCH="$cfg_target_uboot_arch" \
        CROSS_COMPILE="$cfg_target_canonical"-
}

install()
{
    # Machine.
    $cmd_mkdir \
        "$pkg_dir_machine/boot" &&

    if [ -f MLO ]; then
        $cmd_cp MLO "$pkg_dir_machine/boot"
    fi &&

    if [ -f u-boot.img ]; then
        $cmd_cp u-boot.img "$pkg_dir_machine/boot"
    fi
}
