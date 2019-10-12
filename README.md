Test file system
================

File test.img contains a file system image with a partition table hosting a
single partition.

This partition contains a file description.txt with content 'file system on
partition 1'.

The start of the image can alternatively be interpreted as a separate file
system containing a file description.txt with content 'file system on block
device'.

In U-Boot we only should install the simple file system protocol on the
partition and not on the block device.

test.sh is a script that can be used to recreate the image.
