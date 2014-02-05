source "$pkg_common"

requires=\
(
    'ncurses/host'
)

configure()
{
    "../readline-$version/configure" \
        --prefix="$cfg_dir_root" \
	--disable-nls \
        --with-shared
}

build()
{
    $cmd_make \
        SHLIB_LIBS=-lncurses \
        all \
        shared
}

install()
{
    $cmd_make \
        prefix="$pkg_dir_host" \
        install &&

    rm -rf \
        "$pkg_dir_host/bin" \
        "$pkg_dir_host/share"
}
