version=\
(
    '4.6.5'
)

url=\
(
    "http://downloads.sourceforge.net/gnuplot/gnuplot/$version/gnuplot-$version.tar.gz"
)

md5=\
(
    '9a476b21f74bd99c876f1509d731a0f9'
)

configure()
{
    ./configure \
        --prefix="${cfg_dir_toolchain_sysroot}/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --disable-history-file \
        --without-x \
        --disable-raise-console \
        --disable-mouse \
        --without-tutorial \
        --without-demo \
        --disable-demo \
        --without-row-help \
        --disable-history-file \
        --without-lisp-files \
        --disable-wxwidgets \
        --without-lua \
        --without-latex \
        --without-cairo

    sed -i "s#demo ##g" Makefile
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}

target_install()
{
    $cmd_target_strip -v "$cfg_dir_toolchain_sysroot/usr/bin/gnuplot" -o 	"$cfg_dir_rootfs/usr/bin/gnuplot"
    $cmd_cp "$cfg_dir_toolchain_sysroot/usr/share/gnuplot" 		"$cfg_dir_rootfs/usr/share"
}
