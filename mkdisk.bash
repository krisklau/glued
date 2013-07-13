#! /bin/bash
#############################################################################
# Copyright (C) 2007-2012 Laboratório de Sistemas e Tecnologia Subaquática  #
# Departamento de Engenharia Electrotécnica e de Computadores               #
# Rua Dr. Roberto Frias, 4200-465 Porto, Portugal                           #
#############################################################################
# Author: Ricardo Martins                                                   #
#############################################################################
# $Id::                                                                   $:#
#############################################################################

cmd_parted()
{
    dev="$1"; shift
    "$cmd_parted" "$dev" -a cylinder -s -- $@
}

cmd_mount()
{
    fs="$1"
    dev="$2"
    mkdir -p mount &&
    mount -t "$fs" "$dev" mount
}

cmd_unmount()
{
    while [ 1 ]; do
        (umount mount && rmdir mount) > /dev/null 2>&1
        [ $? -eq 0 ] && break
        sleep 1
    done
}

die()
{
    umount mount > /dev/null 2>&1
    rmdir mount > /dev/null 2>&1
    [ -n "$dev_loop" ] && losetup -d "$dev_loop"
    exit 1
}

create_part_xboot()
{
    nfo1 "X-Boot partition ($part_label)"

    nfo2 "Creating partition"
    cmd_parted "$dev_loop" \
        mkpart primary fat32 "$part_start" "$part_end" \
        set "$part_nr" boot on \
        align-check minimal "$part_nr" \
        || die

    nfo2 "Creating filesystem"
    $cmd_mkdosfs -n "$part_label" "$part_dev" > /dev/null || die

    nfo2 "Populating filesystem"
    cmd_mount vfat "$part_dev" || die

    for f in MLO u-boot.img uEnv.txt; do
        if [ -f "$cfg_sys_family/rootfs/boot/$f" ]; then
            nfo2 installing $f to boot partition
            cp "$cfg_sys_family/rootfs/boot/$f" mount || die
        fi
    done

    cmd_parted "$dev_loop" \
        set "$part_nr" lba on \
        || die

    cmd_parted "$dev_loop" print > /dev/null
}

create_part_root()
{
    nfo1 "Root partition ($part_label)"

    nfo2 "Creating partition"
    cmd_parted "$dev_loop" \
        mkpart primary ext2 "$part_start" "$part_end" \
        align-check minimal "$part_nr" \
        || die

    nfo2 "Creating filesystem"
    mkfs.ext2 -q -L "$part_label" "$part_dev" || die

    nfo2 "Populating filesystem"
    cmd_mount ext2 "$part_dev" || die
    tar -C mount -pxf "$cfg_rootfs_tar" || die

    # Install bootloader.
    if [ -f "$cfg_sys_family/toolchain/bin/extlinux" ]; then
        nfo2 "Installing extlinux to root partition"
        "$cfg_sys_family/toolchain/bin/extlinux" -S 63 -H 255 -i mount/boot/extlinux || die
    fi

    cmd_unmount || die

    # Mark partition bootable if needed.
    if [ -f "$cfg_sys_family/toolchain/bin/extlinux" ]; then
        cmd_parted "$dev_loop" \
            set "$part_nr" boot on \
            || die
    fi
}

create_part_data()
{
    nfo1 "Data partition ($part_label)"

    nfo2 "Creating partition"
    cmd_parted "$dev_loop" \
        mkpart primary ext4 "$part_start" "$part_end" \
        align-check minimal "$part_nr" \
        || die

    nfo2 "Creating filesystem"
    mkfs.ext4 -q -L "$part_label" -O dir_index "$part_dev" || die

    nfo2 "Populating filesystem"
    cmd_mount ext4 "$part_dev" || die
    mkdir mount/lsts || die
    cmd_unmount || die
}

export LC_ALL=C

if [ -z "$BASH_VERSION" ]; then
    echo "ERROR: you must use bash to run this script."
    exit 1
fi

if [ "$(whoami)" != 'root' ]; then
    echo "ERROR: you must be root to execute this target."
    exit 1
fi

if [ $# -lt 2 ]; then
    echo "Usage: $0 <config> <disk> [disk_size]"
    exit 1
fi

source "$1"

if ! [ -f "$cfg_rootfs_tar" ]; then
    echo "ERROR: you must run pkrootfs.bash first."
    exit 1
fi

if [ -x "$cfg_dir_toolchain/sbin/parted" ]; then
    cmd_parted="$cfg_dir_toolchain/sbin/parted"
else
    echo "Warning: using system parted, this might lead to errors"
    cmd_parted="parted"
fi

if [ -x "$cfg_dir_toolchain/sbin/mkdosfs" ]; then
    cmd_mkdosfs="$cfg_dir_toolchain/sbin/mkdosfs"
else
    echo "Warning: using system mkdosfs, this might lead to errors"
    cmd_mkdosfs="mkdosfs"
fi

source "functions.bash"

dev="$2"

# unmounting partitions on target device
mounted_partition=$(mount | grep $dev  | cut -f1 -d " ");
if [ ${#mounted_partition} -gt 0 ]; then
    echo "Warning: some partitions of $hd_dev are mounted:"
    for p in ${mounted_partition};
    do
    echo "		unmounting $p";
    umount $p;
    done
fi

if [ -z "$cfg_partitions" ]; then
    cfg_partitions=( \
        'root' 'root0' '512B'  '532MiB'
        'data' 'data0' '532MiB' '-1'
    )
fi

# Loop device.
dev_loop="$(losetup -f)"

nfo1 "Attaching $dev to $dev_loop"
losetup -v "$dev_loop" "$dev"
if [ $? -ne 0 ]; then
    unset dev_loop
    die
fi

nfo1 "Obliterating partition table"
dd if=/dev/zero of="$dev_loop" bs=1 count=1M count=32 > /dev/null 2>&1 || die

nfo1 "Creating empty partition table"
cmd_parted "$dev_loop" \
    mklabel msdos \
    || die

part_nr=1
for ((i = 0; i < ${#cfg_partitions[@]}; i += 4)); do
    part_type="${cfg_partitions[$i+0]}"
    part_label="${cfg_partitions[$i+1]}"
    part_start="${cfg_partitions[$i+2]}"
    part_end="${cfg_partitions[$i+3]}"
    part_dev="${dev_loop}p${part_nr}"

    case $part_type in
        'x-boot')
            create_part_xboot
            ;;
        'root')
            create_part_root
            ;;
        'data')
            create_part_data
            ;;
        *)
            echo "ERROR: unknown partition type '$part_type'"
            die
            ;;
    esac

    let part_nr++
done

if [ -f "$cfg_sys_family/rootfs/boot/extlinux/mbr.bin" ]; then
    nfo1 "Installing bootloader in MBR..."
    dd if="$cfg_sys_family/rootfs/boot/extlinux/mbr.bin" of="$dev_loop" > /dev/null 2>&1
fi

nfo1 "Synchronizing caches"
sync && sync && sync && sync && sync && sync
blockdev --flushbufs "$dev_loop" || die

nfo1 "Detaching loop device $dev_loop"
losetup -v -d "$dev_loop"