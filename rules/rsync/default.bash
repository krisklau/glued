version=\
(
    '3.1.0'
)

url=\
(
    "http://www.samba.org/ftp/rsync/rsync-$version.tar.gz"
)

md5=\
(
    '3be148772a33224771a8d4d2a028b132'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'zlib/default'
)

configure()
{
    ./configure \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="/" \
        --disable-ipv6 \
        --disable-locale \
        --disable-debug \
        --disable-iconv \
        --disable-acl-support \
        --disable-xattr-support \
        --with-included-popt
}

build()
{
    $cmd_make
}

install()
{
    # Host.
    $cmd_make \
        prefix="$pkg_dir_sysroot" \
        install &&

    rm -rf \
        "$pkg_dir_sysroot/share" &&

    # Target.
    $cmd_mkdir \
        "$pkg_dir_target/bin" &&

    $cmd_target_strip \
        "$pkg_dir_sysroot/bin/rsync" \
        -o "$pkg_dir_target/bin/rsync"
}
