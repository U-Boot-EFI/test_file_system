#!/bin/sh
#
# Create a disk image with a partition table and two partitions.
#
# Only the second partition carries a file system. This partition contains a
# file description.txt with content 'file system on partition 2'.
#
# The start of the image can alternatively be interpreted as a separate file
# system containing a file description.txt with content 'file system on block
# device'.

cat > partioning << EOF
label: dos
label-id: 0x6fe3a999
device: image
unit: sectors
image1: start= 512, size= 512, type=da
image2: start=1024, size=1024, type=0c
EOF
dd if=/dev/zero of=test.img count=1 bs=1MiB
/usr/sbin/sfdisk test.img < partioning
dd if=test.img of=partition.tbl bs=8 count=9 skip=55
/usr/sbin/mkfs.vfat test.img 256
dd conv=fsync,notrunc if=partition.tbl of=test.img bs=8 count=9 seek=55
sudo losetup -o 524288 --sizelimit 524288 /dev/loop1 test.img
sudo mkfs.vfat /dev/loop1
sudo losetup -D /dev/loop1
sudo mount test.img /mnt
sudo sh -c "echo 'file system on block device' > /mnt/description.txt"
sudo umount /mnt
sudo mount test.img /mnt -o offset=524288
sudo sh -c "echo 'file system on partition 2' > /mnt/description.txt"
sudo umount /mnt
