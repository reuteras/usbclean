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

PART=""
if [ -e /dev/"$DEVICE"1 ]; then
    PART="1"
fi

if ! grep -qs /dev/$DEVICE$PART /proc/mounts; then
    mount /dev/$DEVICE$PART $MP
fi

COUNT=0

while [ "$COUNT" != "1" ]; do
    find $MP -mindepth 1 -print0 | xargs -0 -n 10 rm -rf > /dev/null 2>&1
    COUNT=$(find $MP -maxdepth 1 | wc -l | awk '{print $1}')
done

TYPE=$(mount | grep $MP | awk '{print $5}')

for ((i=1; i<=$TIMES; i++)); do
    if [[ $TYPE == "vfat" ]]; then
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

umount $MP
rmdir $MP
