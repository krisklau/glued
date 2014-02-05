source "$pkg_common"

post_unpack()
{
    $cmd_cp \
        "../bzip2-$version" \
        "../$pkg_var/sources"
}

build()
{
    cd "../$pkg_var/sources" &&

    # Static library.
    $cmd_make  \
	LD="$cmd_target_ld" \
	CC="$cmd_target_cc" \
	AR="$cmd_target_ar" \
	RANLIB="$cmd_target_ranlib" \
        libbz2.a &&

    # Shared library.
    $cmd_make \
        LD="$cmd_target_ld" \
        CC="$cmd_target_cc" \
        AR="$cmd_target_ar" \
        RANLIB="$cmd_target_ranlib" \
        -f Makefile-libbz2_so &&

    ln -fs \
        "libbz2.so.$version" \
        "libbz2.so.1"
}

install()
{
    cd "../$pkg_var/sources" &&

    # Host.
    $cmd_mkdir \
        "$pkg_dir_sysroot/lib" \
        "$pkg_dir_sysroot/include" &&

    $cmd_cp \
        "bzlib.h" \
        "$pkg_dir_sysroot/include" &&

    chmod 0644 \
        "$pkg_dir_sysroot/include/bzlib.h" &&

    $cmd_cp \
        "libbz2.a" \
        "$pkg_dir_sysroot/lib" &&

    chmod 0644 \
        "$pkg_dir_sysroot/lib/libbz2.a" &&

    $cmd_cp \
        "libbz2.so"* \
        "$pkg_dir_sysroot/lib" &&

    chmod 0755 \
        "$pkg_dir_sysroot/lib/libbz2.so"*

    # Target.
    $cmd_mkdir \
        "$pkg_dir_target/lib" &&

    $cmd_cp \
        "$pkg_dir_sysroot/lib/"*.so* \
        "$pkg_dir_target/lib" &&

    $cmd_target_strip \
        "$pkg_dir_target/lib/"*
}
