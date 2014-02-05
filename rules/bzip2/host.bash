source "$pkg_common"

build()
{
    export CFLAGS="$CFLAGS -fPIC"

    # Static library.
    $cmd_make \
        bzip2 &&

    # Shared library.
    $cmd_make \
        -f Makefile-libbz2_so &&

    ln -fs \
        "libbz2.so.$version" \
        "libbz2.so.1"
}

install()
{
    $cmd_mkdir \
        "$pkg_dir_host/bin" &&

    $cmd_cp \
        "bzip2" \
        "$pkg_dir_host/bin" &&

    $cmd_mkdir \
        "$pkg_dir_host/include" &&

    $cmd_cp \
        "bzlib.h" \
        "$pkg_dir_host/include" &&

    $cmd_mkdir \
        "$pkg_dir_host/lib" &&

    $cmd_cp \
        "libbz2.a" \
        "$pkg_dir_host/lib" &&

    $cmd_cp \
        "libbz2.so"* \
        "$pkg_dir_host/lib"
}
