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
    # Host.
    $cmd_mkdir \
        "$pkg_dir_host/bin" &&

    $cmd_cp \
        "tools/mkimage" \
        "$pkg_dir_host/bin"

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
