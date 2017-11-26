#!/bin/bash

# compile bootloader code
nasm -f bin -o bootloader.bin bootloader.asm

# launch created bin in qemu
qemu-system-x86_64 bootloader.bin

#dd if=/dev/zero of=bootloader.img bs=512 count=2880
#dd status=noxfer conv=notrunc if=bootloader.bin of=bootloader.img
#qemu-system-x86_64 bootloader.img
