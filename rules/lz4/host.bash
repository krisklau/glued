version=\
(
    '112'
)

url=\
(
    "https://lz4.googlecode.com/files/lz4-r$version.tar.gz"
)

md5=\
(
    'f4bf7806d6a9fd2db428febf6861b94d'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

build()
{
    cd "../lz4-r$version" &&
    $cmd_make
}

host_install()
{
    # Host.
    prefix="$pkg_dir_host/bin"

    $cmd_mkdir "$prefix" &&
    strip -v --strip-unneeded \
        "../lz4-r$version/programs/lz4" \
        -o "$prefix/lz4" &&

    strip -v --strip-unneeded \
        "../lz4-r$version/programs/lz4c" \
        -o "$prefix/lz4c"
}
