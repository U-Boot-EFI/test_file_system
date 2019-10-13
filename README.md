Test file system
================

In the UEFI sub-system we only want to install the simple file system
protocol on a partition having a file system.

test.img provides a disk image having:

* a partition table that looks like the start of a file system
* a first partition without a file system
* a second partition with a file system

The file system of the second partition contains a file description.txt with
content 'file system on partition 2'.

The start of the image can alternatively be interpreted as a separate file
system containing a file description.txt with content 'file system on block
device'.

create\_image.sh is a script that can be used to recreate the image.
