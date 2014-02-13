version=\
(
    '0.18.3.1'
)

url=\
(
    "http://ftp.gnu.org/pub/gnu/gettext/gettext-$version.tar.gz"
)

md5=\
(
    '3fc808f7d25487fc72b5759df7419e02'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    "../gettext-$version/configure" \
        --prefix="" \
        --disable-nls
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
        "$pkg_dir_host/share/man" \
        "$pkg_dir_host/share/info" \
        "$pkg_dir_host/share/doc" \
        "$pkg_dir_host/share/emacs" &&

    find "$pkg_dir_host/lib" -type f -name '*.la' | while read f; do
        libtool_replace_libdir "$f" "/lib" "$cfg_dir_root/lib"
    done
}
