#!/bin/bash

DEVICE=$(dmesg | grep "Attached SCSI removable disk" | sed -e "s/.*\[//" | sed -e "s/\].*//" | tail -1)
[ -z "$DEVICE" ] && exit 1

MP=/mnt/$DEVICE
TIMES=1

if [ ! -e /dev/$DEVICE ]; then
    exit 1
fi

if [ ! -d "$MP" ]; then
    mkdir $MP
fi

if ! grep -qs /dev/"$DEVICE"1 /proc/mounts; then
    mount /dev/"$DEVICE"1 $MP
fi

rm -rf $MP/*

TYPE=$(mount | grep $MP | awk '{print $5}')

for ((i=1; i<=$TIMES; i++)); do
    if [[ $TYPE == "vfat" ]]; then
        i=0
        while true; do
            dd if=/dev/urandom of=$MP/zero.$i bs=512 count=1048570 || break
            i=$(( i + 1 ))
        done
    else
        dd if=/dev/urandom of=$MP/zero || true
    fi
    sync
    rm -f $MP/zero*
done

dd if=/dev/zero of=/dev/$DEVICE bs=446 count=1

umount $MP
rmdir $MP
