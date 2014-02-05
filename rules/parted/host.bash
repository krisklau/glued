version=\
(
    '3.1'
)

url=\
(
    "http://ftp.gnu.org/gnu/parted/parted-$version.tar.xz"
)

md5=\
(
    '5d89d64d94bcfefa9ce8f59f4b81bdcb'
)

configure()
{
    ./configure                       \
	--prefix="$cfg_dir_root"      \
        --without-readline            \
	--disable-device-mapper       \
	--disable-shared              \
	--enable-static               \
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
        "$pkg_dir_host/share" \
        "$pkg_dir_host/include" \
        "$pkg_dir_host/lib"
}
