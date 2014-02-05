version=\
(
    '6.2'
)

revision=\
(
    '1'
)

url=\
(
    "ftp://ftp.gnu.org/gnu/readline/readline-$version.tar.gz"
)

md5=\
(
    '67948acb2ca081f23359d0256e9a271c'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

post_unpack()
{
    patches=$(ls "$pkg_dir/patches/"*.patch)
    if [ -n "$patches" ]; then
        cat $patches | patch -p0
    fi
}
