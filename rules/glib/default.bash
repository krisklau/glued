source "$pkg_common"

requires=\
(
    'pcre/default'
    'libffi/default'
    'python2/host'
)

configure()
{
    $cmd_make \
        distclean > /dev/null 2>&1

    export glib_cv_stack_grows=no
    export glib_cv_uscore=yes
    export ac_cv_func_posix_getpwuid_r=yes
    export ac_cv_func_posix_getgrgid_r=yes

    ./configure \
        --prefix="$pkg_dir_sysroot" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --enable-gtk-doc-html=no \
        --enable-xattr=no \
        --with-pcre=system \
        --with-libiconv=no \
        --disable-silent-rules
}

build()
{
    $cmd_make
}

install()
{
    # Host.
    $cmd_make \
        install &&

    rm -rf \
        "$pkg_dir_sysroot/share" &&

    find "$pkg_dir_sysroot/lib" -type f -name '*.la' | while read f; do
        libtool_replace_libdir "$f" "$pkg_dir_sysroot/lib" "$cfg_dir_sysroot/lib"
    done
}
