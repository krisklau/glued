version=\
(
    '1.4.17'
)

url=\
(
    "http://ftp.gnu.org/gnu/m4/m4-$version.tar.bz2"
)

md5=\
(
    '8a1787edcba75ae5cd1dc40d7d8ed03a'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

post_unpack()
{
    patches=$(ls "$cfg_package_spec_dir/patches/"*.patch)
    if [ -n "$patches" ]; then
        cd "../m4-$version" && cat $patches | patch -p1
    fi
}

configure()
{
    ./configure \
        --prefix="$cfg_dir_root" \
        --disable-shared \
        --enable-static
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
        "$pkg_dir_host/share"
}
