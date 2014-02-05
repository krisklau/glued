source "$pkg_common"

requires=\
(
    'gcc/cross_stage1'
    'linux-headers/cross'
)

install()
{
    cat >> configparms << EOF
install-bootstrap-headers=yes
cross-compiling=yes
install_root="$pkg_dir_sysroot"
EOF

    $cmd_mkdir \
        "$pkg_dir_sysroot" &&

    ln -fs \
        . \
        "$pkg_dir_sysroot/usr" &&

    $cmd_make \
        install-bootstrap-headers=yes \
        install-headers &&

    $cmd_make \
        csu/subdir_lib &&

    $cmd_mkdir \
        "$pkg_dir_sysroot/lib" &&

    cp -v \
        csu/crt1.o \
        csu/crti.o \
        csu/crtn.o \
        "$pkg_dir_sysroot/lib" &&

    $cmd_target_cc \
        -nostdlib \
        -nostartfiles \
        -shared \
        -x c /dev/null -o "$pkg_dir_sysroot/lib/libc.so"
}
