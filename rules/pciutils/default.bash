version=\
(
    '3.1.8'
)

url=\
(
    "ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/pciutils-$version.tar.gz"
)

md5=\
(
    '79312f138311d29291c7d44d624cd37e'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

build()
{
    $cmd_make \
        CC="$cmd_target_cc" \
        ZLIB=yes \
        PREFIX="/" \
        SHAREDIR="/share/pciutils"
}

host_install()
{
    # Host.
    $cmd_make \
        CC="$cmd_target_cc" \
        PREFIX="$pkg_dir_sysroot" \
        install \
        install-lib &&

    rm -rf \
        "$pkg_dir_sysroot/man" &&

    $cmd_mkdir \
        "$pkg_dir_sysroot/share/pciutils" &&

    mv "$pkg_dir_sysroot/share/pci.ids.gz" \
        "$pkg_dir_sysroot/share/pciutils" &&

    # Target
    $cmd_mkdir \
        "$pkg_dir_target/sbin" \
        "$pkg_dir_target/share/pciutils" &&

    for p in lspci setpci; do
        $cmd_target_strip \
            "$pkg_dir_sysroot/sbin/$p" \
            -o "$pkg_dir_target/sbin/$p"
    done &&

    $cmd_cp \
        "$pkg_dir_sysroot/share/pciutils/pci.ids.gz" \
        "$pkg_dir_target/share/pciutils"
}
