version=\
(
    '3.0.2'
)

url=\
(
    "http://dl.lm-sensors.org/i2c-tools/releases/i2c-tools-$version.tar.bz2"
)

md5=\
(
    'b546345ac19db56719dea6b8199f11e0'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

build()
{
    $cmd_make CC="$cmd_target_cc"
}

install()
{
    $cmd_mkdir \
        "$pkg_dir_target/bin" &&

    $cmd_target_strip \
        "tools/i2cdetect" \
        -o "$pkg_dir_target/bin/i2cdetect" &&

    $cmd_target_strip \
        "tools/i2cget" \
        -o "$pkg_dir_target/bin/i2cget" &&

    $cmd_target_strip \
        "tools/i2cset" \
        -o "$pkg_dir_target/bin/i2cset"
}
