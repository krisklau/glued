source "$pkg_common"

requires=\
(
    'ncurses/host'
    'zlib/host'
    'expat/host'
)

configure()
{
    pkg_config_env_host

    make distclean > /dev/null 2>&1

    CFLAGS="-I$cfg_dir_root/include" \
	LDFLAGS="-L$cfg_dir_root/lib" \
	"../gdb-$version/configure" \
        --prefix="$cfg_dir_root" \
        --target="$cfg_target_canonical" \
        --host="$cfg_host_canonical" \
        --build="$cfg_host_canonical" \
        --with-sysroot="$cfg_dir_sysroot" \
        --disable-nls \
        --disable-tui
}

build()
{
    $cmd_make
}

install()
{
    $cmd_make \
        prefix="$pkg_dir_host" \
        install &&

    rm -rf \
        "$pkg_dir_host/share/info" \
        "$pkg_dir_host/share/man" \
        "$pkg_dir_host/lib/libiberty.a"
}
