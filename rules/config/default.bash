version=\
(
    '1.0'
)

revision=\
(
    '1'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

refresh()
{
    rm \
        "$cfg_dir_builds/$pkg/$pkg_var/.install" \
        rm "$cfg_dir_builds/$pkg/$pkg_var/.make_package"
}

install()
{
    $cmd_mkdir \
        "$pkg_dir_machine/etc" &&

    set \
        | sort \
        | grep ^cfg_ \
        | egrep -v '^cfg_dir|^cfg_target|^cfg_host_|^cfg_toolchain|^cfg_rootfs_tar|^cfg_partitions|^cfg_packages' \
        > "$pkg_dir_machine/etc/config"

    echo -e \
        "127.0.0.1\tlocalhost.localdomain\tlocalhost" > "$pkg_dir_machine/etc/hosts"
}
