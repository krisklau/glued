source "$pkg_common"

require=\
(
    'zlib/host'
)

configure()
{
    $cmd_make \
        distclean

    ./configure \
        --shared \
        --prefix="$cfg_dir_root"
}

build()
{
    $cmd_make -j1
}

install()
{
    $cmd_make \
        -j1 \
        prefix="$pkg_dir_host" \
        install &&

    rm -rf \
        "$pkg_dir_host/share"
}