source "$pkg_common"

requires=\
(
    'gcc/cross_stage2'
)

build()
{
    $cmd_make
}

install()
{
    # Host.
    $cmd_mkdir \
        "$pkg_dir_sysroot" &&

    ln -nfs \
        . \
        "$pkg_dir_sysroot/usr" &&

    $cmd_make \
        -j1\
        install_root="$pkg_dir_sysroot" \
        install &&

    $cmd_cp \
        "$pkg_dir/files/timepps.h" \
        "$pkg_dir_sysroot/include" &&

    # Locales.
    $cmd_mkdir \
        "localedef" &&

    cd localedef &&

    "../../eglibc-$version/localedef/configure" \
        --prefix="$pkg_dir_sysroot" \
        --localedir="$pkg_dir_sysroot/lib/locale" \
        --with-glibc="$pkg_dir_build/../eglibc-$version/libc" &&

    $cmd_make && cd -

    charmap_utf8="$pkg_dir_sysroot/share/i18n/charmaps/UTF-8.gz"
    if [ -f "$charmap_utf8" ]; then
        gunzip -f "$charmap_utf8"
    fi &&

    $cmd_mkdir \
        "$pkg_dir_sysroot/lib/locale" &&

    for l in pt_PT ru_RU; do
        ./localedef/localedef -v -c -i "$l" -f UTF-8 "$l"
    done

    # Target.
    $cmd_mkdir \
        "$pkg_dir_target/etc" \
        "$pkg_dir_target/sbin" \
        "$pkg_dir_target/lib" &&

    find "$pkg_dir_sysroot/lib" -maxdepth 1 -type f -name '*.so*' | while read f; do
        base="$(basename "$f")"
        $cmd_target_strip "$f" -o "$pkg_dir_target/lib/$base"
    done &&

    find "$pkg_dir_sysroot/lib" -maxdepth 1 -type l -name '*.so*' | while read f; do
        $cmd_cp "$f" "$pkg_dir_target/lib"
    done &&

    $cmd_target_strip \
        "$pkg_dir_sysroot/sbin/ldconfig" \
        -o "$pkg_dir_target/sbin/ldconfig" &&

    $cmd_mkdir \
        "$pkg_dir_target/lib/locale" &&

    $cmd_cp \
        "$pkg_dir_sysroot/lib/locale/locale-archive" \
        "$pkg_dir_target/lib/locale" &&

    $cmd_cp \
        "$pkg_dir_sysroot/etc/rpc" \
        "$pkg_dir_target/etc" &&

    $cmd_cp \
        "$pkg_dir_sysroot/share/zoneinfo/Zulu" \
        "$pkg_dir_target/etc/localtime" &&

    $cmd_cp \
        "$pkg_dir/fs/"* \
        "$pkg_dir_target"
}
