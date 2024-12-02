# building linux kernel as x86_64 on aarch64 (M1 Mac)
# not for running so much as it is for notes
apt-get update && apt-get upgrade

apt-get install build-essential libncurses5-dev gcc-x86-64-linux-gnu g++-x86-64-linux-gnu flex bison libssl-dev libelf-dev

# configure linux
# make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- defconfig
# enable debugging in kernel hacking
make ARCH=x86_64 menuconfig
make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- -j{cores}

apt-get install qemu qemu-system

qemu-system-x86_64 -kernel arch/x86/boot/bzImage -hda /dev/zero -append "root=/dev/zero console=ttyS0" -serial stdio -display none

# Buildroot-based filesystem
wget http://buildroot.org/downloads/buildroot-2024.08.tar.gz
git clone https://gitlab.com/buildroot.org/buildroot.git

# set target architecture to x86_64
# filesystem images -> ext4
make menuconfig
make ARCH=x86_64 -j2

# running the kernel
# user - root; password -
qemu-system-x86_64 -s -kernel arch/x86/boot/bzImage -boot c -m 2049M -hda <path to buildroot>/output/images/rootfs.ext4 -append "root=/dev/sda rw console=ttyS0,115200 acpi=off nokaslr" -serial stdio -display none
# running the kernel w/ gdb
qemu-system-x86_64 -s -S  -kernel arch/x86/boot/bzImage -boot c -m 2049M -hda ~/Downloads/buildroot-2021.02.8/output/images/rootfs.ext4 -append "root=/dev/sda rw console=ttyS0,115200 acpi=off nokaslr" -serial stdio -display none

# Busybox-based filesystem
# Note: currently Ubuntu 24 is not supported by Busybox: https://bugs.busybox.net/show_bug.cgi?id=15931
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
qemu-system-aarch64 -M virt -m 128M -nographic -kernel Image -initrd rootfs.img.gz -append "root=/dev/ram rdinit=/bin/sh"

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

qemu-system-aarch64 -M virt -m 128M -nographic -kernel Image -initrd rootfs.img.gz -append "root=/dev/ram rdinit=/sbin/init"

