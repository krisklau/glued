post_unpack()
{
    patches=$(ls "$pkg_dir/patches-$version/"*.patch\
	"$cfg_dir_system/patches/linux/patches-${version}/"*.patch 2>/dev/null)
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi

    if [ -d "$cfg_dir_sysroot/firmware" ]; then
        $cmd_cp \
            "$cfg_dir_sysroot/firmware/"* \
            "firmware"
    fi
}

refresh()
{
    for rule in configure build target_install; do
        if [ "$cfg_dir_system/cfg/linux-${version}.cfg" -nt "$cfg_dir_builds/linux/$pkg_var/.$rule" ]; then
            rm "$cfg_dir_builds/linux/$pkg_var/.$rule"
        fi
    done
}

configure()
{
    # Cleanup.
    $cmd_make \
        ARCH="$cfg_target_linux" \
        mrproper &&

    # Copy configuration.
    cp \
        "$cfg_dir_system/cfg/linux-$version.cfg" \
        .config &&

    # Commit configuration.
    yes '' | $cmd_make \
        CROSS_COMPILE="$cfg_target_canonical-" \
        ARCH="$cfg_target_linux" \
        oldconfig
}

build()
{
    # Build kernel.
    $cmd_make \
        CROSS_COMPILE="$cfg_target_canonical-" \
        ARCH="$cfg_target_linux" &&

    # Build modules.
    $cmd_make \
        CROSS_COMPILE="$cfg_target_canonical-" \
        ARCH="$cfg_target_linux" \
        modules &&

    # U-Boot image.
    if [ "$(basename $cfg_target_linux_kernel)" = 'uImage' ]; then
        $cmd_make \
            CROSS_COMPILE="$cfg_target_canonical-" \
            ARCH="$cfg_target_linux" \
            uImage
    fi &&

    # Compressed image.
    if [ "$(basename $cfg_target_linux_kernel)" = 'zImage' ]; then
        $cmd_make \
            CROSS_COMPILE="$cfg_target_canonical-" \
            ARCH="$cfg_target_linux" \
            zImage
    fi &&

    # Device tree blob.
    if [ -n "$cfg_target_linux_dtb" ]; then
        $cmd_make \
            CROSS_COMPILE="$cfg_target_canonical-" \
            ARCH="$cfg_target_linux" \
            dtbs
    fi
}

target_install()
{
    $cmd_mkdir \
        "$pkg_dir_target/boot" &&

    # Kernel image.
    if [ -n "$cfg_target_linux_kernel" ]; then
        $cmd_cp "$cfg_target_linux_kernel" "$pkg_dir_target/boot/kernel"
    fi &&

    # Device tree blob.
    if [ -n "$cfg_target_linux_dtb" ]; then
        $cmd_cp "$cfg_target_linux_dtb" "$pkg_dir_target/boot/board.dtb"
    fi &&

    # Modules.
    $cmd_make \
        CROSS_COMPILE="$cfg_target_canonical-" \
        ARCH="$cfg_target_linux" \
        INSTALL_MOD_PATH="$pkg_dir_target" \
        modules_install &&

    # Firmware.
    $cmd_make \
        CROSS_COMPILE="$cfg_target_canonical-" \
        ARCH="$cfg_target_linux" \
        INSTALL_MOD_PATH="$pkg_dir_target" \
        firmware_install
}
