version=\
(
    '3.0.0'
)

url=\
(
    "ftp://ftp.info-zip.org/pub/infozip/src/zip30.tgz"
)

md5=\
(
    '7b74551e63f8ee6aab6fbc86676c0d37'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

build()
{
    cd ../zip30 &&

    $cmd_make \
        -f unix/Makefile generic
}

install()
{
    cd ../zip30 &&
    $cmd_make \
        prefix="$pkg_dir_host" \
        -f unix/Makefile \
        install &&

    rm -rf "$pkg_dir_host/man"
}
