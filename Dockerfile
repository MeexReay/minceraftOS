FROM ghcr.io/void-linux/void-glibc:20250701r1

WORKDIR /mnt/workdir
COPY . .

RUN xbps-install -Syu bash make lzlib grub-x86_64-efi grub-i386-efi dosfstools xorriso mtools util-linux kmod

CMD yes | ./mkiso
