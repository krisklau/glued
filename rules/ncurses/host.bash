source "$pkg_common"

configure()
{
    $cmd_make \
        distclean > /dev/null 2>&1

    "../ncurses-$version/configure" \
        --prefix="$cfg_dir_root" \
	--with-shared \
	--enable-pc-files \
	--without-progs \
	--without-tests \
	--without-profile \
	--without-debug \
        --without-manpages \
        --without-ada \
	--disable-big-core \
	--disable-rpath \
        --disable-nls \
	--enable-echo \
	--enable-const \
	--enable-overwrite \
        --enable-widec
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
        "$pkg_dir_host/man"
}
