version=\
(
    '1.0'
)

url=\
(
    "http://www.lsts.pt/glued/gnu-config-$version.tar.bz2"
)

md5=\
(
    '6bd074b651c9145466532bd8786fbb30'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

install()
{
    dir="$pkg_dir_host/share/gnu-config"

    $cmd_mkdir \
        "$dir" &&

    $cmd_cp \
        "../gnu-config-$version/config.sub" \
        "../gnu-config-$version/config.guess" \
        "$dir"
}
