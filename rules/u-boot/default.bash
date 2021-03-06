version=\
(
    '2014.07'
)

url=\
(
    "ftp://ftp.denx.de/pub/u-boot/u-boot-$version.tar.bz2"
)

md5=\
(
    '36d4bad687edcafa396fee607e505d4e'
)

post_unpack()
{
    patches=$(ls "$pkg_dir/patches/$version/"*.patch\
	"$cfg_dir_system/patches/u-boot/$version/"*.patch 2>/dev/null)
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

configure()
{
    $cmd_make \
        "${cfg_target_uboot_config}_config"
}

build()
{
    $cmd_make \
        CROSS_COMPILE="$cfg_target_canonical"-
}

host_install()
{
    $cmd_cp \
        tools/mkimage \
        "$cfg_dir_toolchain/bin"
}

target_install()
{
    if [ -f MLO ]; then
        $cmd_cp MLO "$cfg_dir_rootfs/boot"
    fi

    if [ -f u-boot.img ]; then
        $cmd_cp u-boot.img "$cfg_dir_rootfs/boot"
    fi
}
