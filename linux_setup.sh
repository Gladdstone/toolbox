# building linux kernel on aarch64
# not for running so much as it is for notes
apt-get update && apt-get upgrade

apt-get install build-essential
apt-get install gcc g++ gcc-doc
apt-get install libncurses-dev
apt-get install gcc-aarch64-linux-gnu
apt-get install flex
apt-get install bison
apt install libssl-dev

# configure linux
# make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- defconfig
# make ARCH=arm64 menuconfig
# make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- all

# configure busybox filesystem
# currently, Ubuntu 24 is not supported by Busybox: https://bugs.busybox.net/show_bug.cgi?id=15931
# Recommend Ubuntu 22 or Debian
wget https://busybox.net/downloads/busybox-1.36.1.tar.bz2
tar -xvf busybox-1.36.1.tar.bz2
cd busybox-1.36.1
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
# set to static rather than shared
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- install

cd _install
find . | cpio -o --format=newc > ../rootfs.img
cd ../
gzip -c rootfs.img > rootfs.img.gz

# run kernel
qemu-system-arm -M virt -m 128M -nographic -kernel Image -initrd rootfs.img.gz -append "root=/dev/ram rdinit=/bin/sh"

# configure sys and dev directories
cd _install
mkdir proc sys dev etc etc/init.d
cd ../

# create _install/etc/rcS
# !#/bin/sh
mount -t proc none /proc
mount -t sysfs none /sys
/sbin/mdev -s
# make executable with chmod

qemu-system-arm -M virt -m 128M -nographic -kernel Image -initrd rootfs.img.gz -append "root=/dev/ram rdinit=/sbin/init"

