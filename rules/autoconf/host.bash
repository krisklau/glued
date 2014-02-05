version=\
(
    '2.69'
)

url=\
(
    "http://ftp.gnu.org/gnu/autoconf/autoconf-$version.tar.gz"
)

md5=\
(
    "82d05e03b93e45f5a39b828dc9c6c29b"
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
    "../autoconf-$version/configure" \
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
