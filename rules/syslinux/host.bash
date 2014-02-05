source "$pkg_common"

install()
{
    $cmd_make \
        clean &&

    $cmd_make &&

    $cmd_mkdir \
        "$pkg_dir_host/bin" &&

    cp -v -d \
        "extlinux/extlinux" \
        "$pkg_dir_host/bin" &&

    $cmd_mkdir \
        "$pkg_dir_host/boot" &&

    cp -v -d \
        "mbr/mbr.bin" \
        "$pkg_dir_host/boot"
}
