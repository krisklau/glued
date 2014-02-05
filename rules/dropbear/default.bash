version=\
(
    '2013.62'
)

url=\
(
    "https://matt.ucc.asn.au/dropbear/releases/dropbear-$version.tar.bz2"
)

md5=\
(
    'ca2c7932a1399cf361f795aaa3843998'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'zlib/default'
)

post_unpack()
{
    patches=$(ls "$pkg_dir/patches/"*.patch)
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi

    # Just to avoid make install failure.
    cp -v dbclient.1 scp.1
}

configure()
{
    "../dropbear-$version/configure" \
        --prefix="/" \
        --disable-utmp \
        --disable-utmpx \
        --disable-wtmp \
        --disable-wtmpx \
        --disable-lastlog \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --with-zlib="$cfg_dir_root"
}

build()
{
    $cmd_make \
        PROGRAMS="dropbear dbclient dropbearkey dropbearconvert scp" \
        MULTI=1
}

host_install()
{
    # Host.
    $cmd_make \
        PROGRAMS="dropbear dbclient dropbearkey dropbearconvert scp" \
        MULTI=1 \
        prefix="$pkg_dir_sysroot" \
        install &&

    ln -fs ../bin/dropbearmulti "$pkg_dir_sysroot/sbin/dropbear" &&
    ln -fs dropbearmulti "$pkg_dir_sysroot/bin/dbclient" &&
    ln -fs dropbearmulti "$pkg_dir_sysroot/bin/dropbearkey" &&
    ln -fs dropbearmulti "$pkg_dir_sysroot/bin/dropbearconvert" &&
    ln -fs dropbearmulti "$pkg_dir_sysroot/bin/scp" &&

    rm -rf \
        "$pkg_dir_sysroot/share" &&

    # Target.
    $cmd_cp \
        "$pkg_dir_sysroot/"* \
        "$pkg_dir_target" &&

    $cmd_target_strip \
        "$pkg_dir_target/bin/dropbearmulti" &&

    $cmd_cp \
        "$pkg_dir/fs"/* \
        "$pkg_dir_target" &&

    $cmd_mkdir \
        "$pkg_dir_target/etc/dropbear"
}
