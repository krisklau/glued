version=\
(
    '2.2.0'
)

url=\
(
    "http://downloads.sourceforge.net/ptpd/ptpd-$version.tar.gz"
)

md5=\
(
    'c63a3a149d30c710773ccb02df5782a3'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

build()
{
    make CC="$cmd_target_cc" -C src
}

install()
{
    # Target.
    $cmd_mkdir \
        "$pkg_dir_target/bin" &&

    $cmd_target_strip \
        "src/ptpd2" \
        -o "$pkg_dir_target/bin/ptpd2" &&

    $cmd_cp \
        "$pkg_dir/fs"/* \
        "$pkg_dir_target"
}
