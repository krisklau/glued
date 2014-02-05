version=\
(
    '2.4.2'
)

url=\
(
    "http://ftp.gnu.org/gnu/libtool/libtool-$version.tar.xz"
)

md5=\
(
    '2ec8997e0c07249eb4cbd072417d70fe'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'm4/host'
)

configure()
{
    "../libtool-$version/configure" \
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
        "$pkg_dir_host/share/emacs" \
        "$pkg_dir_host/share/man"
}
