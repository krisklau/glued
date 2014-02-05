source "$pkg_common"

install()
{
    # Target
    $cmd_make \
        clean &&

    $cmd_make \
        CC="$cmd_target_cc" &&

    $cmd_mkdir \
        "$pkg_dir_target/sbin" &&

    $cmd_target_strip \
        "extlinux/extlinux" \
        -o "$pkg_dir_target/sbin/extlinux" &&

    $cmd_mkdir \
        "$pkg_dir_target/boot/extlinux" &&

    $cmd_cp \
        "mbr/mbr.bin" \
        "$pkg_dir_target/boot/extlinux" &&

    # Machine.
    if [ -n "$cfg_terminal" ]; then
        cfg_kernel_extra_args="$cfg_kernel_extra_args console=$cfg_terminal,115200"
        port="$(echo $cfg_terminal | sed 's/ttyS//g')"
        console="SERIAL $port 115200"
    fi &&

    if [ -z "$cfg_kernel_boot_dev" ]; then
        export cfg_kernel_boot_dev='/dev/sda1'
    fi &&

    $cmd_mkdir \
        "$pkg_dir_machine/boot/extlinux" &&

    (echo $console ; cat "$pkg_dir/extlinux.conf") \
        | sed "s%\$cfg_kernel_extra_args%$cfg_kernel_extra_args%g" \
        | sed "s%\$cfg_kernel_boot_dev%$cfg_kernel_boot_dev%g" \
        >  "$pkg_dir_machine/boot/extlinux/extlinux.conf"
}
