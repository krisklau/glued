version=\
(
    '1.0'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

install()
{
    $cmd_mkdir \
        "$pkg_dir_target"/{dev,boot,proc,sys,mnt,etc,bin,sbin,opt,var,root,usr,opt,lib} \
        "$pkg_dir_target"/dev/{shm,pts} \
        "$pkg_dir_target"/etc/rc.d &&

    ln -fs dev/shm "$pkg_dir_target"/tmp &&
    ln -fs ../tmp "$pkg_dir_target"/var/tmp &&
    ln -fs ../tmp "$pkg_dir_target"/var/run &&
    ln -fs ../tmp "$pkg_dir_target"/var/log &&
    ln -fs ../tmp "$pkg_dir_target"/var/lock &&
    ln -fs /sbin/init "$pkg_dir_target"/init &&
    ln -fs /tmp/resolv.conf "$pkg_dir_target"/etc/resolv.conf &&
    ln -fs /proc/self/mounts "$pkg_dir_target"/etc/mtab &&

    if [ -n "$cfg_target_lib64" ]; then
        ln -fs lib "$pkg_dir_target/lib64"
    fi

    $cmd_mkdir "$pkg_dir_target/root/.ssh" &&
    chmod 0700 "$pkg_dir_target/root/.ssh" &&

    $cmd_cp \
        "$pkg_dir/fs/"* \
        "$pkg_dir_target" &&

    if [ -d "$cfg_dir_system/fs" ]; then
        $cmd_cp \
            "$cfg_dir_system/fs/"* \
            "$pkg_dir_target"
    fi
}
