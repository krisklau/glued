source $PKG_COMMON

requires=\
(
    'ncurses/host'
)

configure()
{
    cd "$pkg_build_dir" &&
    CFLAGS=-I"$cfg_dir_toolchain/include" \
	LDFLAGS=-L"$cfg_dir_toolchain/lib" \
	"../gdb-$version/configure" \
        --prefix="$cfg_dir_toolchain" \
        --target="$cfg_target_canonical" \
        --host="$cfg_host_canonical" \
        --build="$cfg_host_canonical" \
        --with-sysroot="$cfg_dir_toolchain_sysroot" \
        --disable-nls \
        --disable-tui
}

build()
{
    $cmd_make -C "$pkg_build_dir"
}

host_install()
{
    $cmd_make -C "$pkg_build_dir" install
    rm -rf "$cfg_dir_toolchain"/{info,man}
}
