version=\
(
    '1.11.1'
)
url=\
(
    "http://ftp.gnu.org/gnu/automake/automake-$version.tar.bz2"
)

md5=\
(
    'c2972c4d9b3e29c03d5f2af86249876f'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'autoconf/host'
)

configure()
{
    "../automake-$version/configure" \
        --prefix="$cfg_dir_root"
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
        "$pkg_dir_host/share/doc" \
        "$pkg_dir_host/share/man"
}
