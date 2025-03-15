#!/bin/sh -x
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

if ! type getarg >/dev/null 2>&1 && ! type getargbool >/dev/null 2>&1; then
    . /lib/dracut-lib.sh
fi

echo minceraftos > ${NEWROOT}/etc/hostname

USERNAME=player
USERSHELL=bash

[ -z "$USERNAME" ] && USERNAME=player
[ -x $NEWROOT/bin/bash -a -z "$USERSHELL" ] && USERSHELL=/bin/bash
[ -z "$USERSHELL" ] && USERSHELL=/bin/bash

# Create /etc/default/live.conf to store USER.
echo "USERNAME=$USERNAME" >> ${NEWROOT}/etc/default/live.conf
chmod 644 ${NEWROOT}/etc/default/live.conf

if ! grep -q ${USERSHELL} ${NEWROOT}/etc/shells ; then
    echo ${USERSHELL} >> ${NEWROOT}/etc/shells
fi

# Create new user and remove password. We'll use autologin by default.
chroot ${NEWROOT} useradd -m -c player -G audio,video,wheel player
chroot ${NEWROOT} passwd -d $USERNAME >/dev/null 2>&1

# Setup default root/user password (voidlinux).
chroot ${NEWROOT} sh -c 'echo "player:password" | chpasswd -c SHA512'
chroot ${NEWROOT} sh -c 'echo "root:password" | chpasswd -c SHA512'

# Enable sudo permission by default.
if [ -f ${NEWROOT}/etc/sudoers ]; then
    echo "${USERNAME} ALL=(ALL:ALL) NOPASSWD: ALL" > "${NEWROOT}/etc/sudoers.d/99-void-live"
fi

echo "${USERNAME} minceraftos = (root) NOPASSWD: /usr/bin/poweroff
${USERNAME} minceraftos = (root) NOPASSWD: /usr/bin/reboot
${USERNAME} minceraftos = (root) NOPASSWD: /usr/sbin/startx
${USERNAME} minceraftos = (root) NOPASSWD: /usr/bin/plymouth" > "${NEWROOT}/etc/sudoers.d/99-void-live"

if [ -d ${NEWROOT}/etc/polkit-1 ]; then
    # If polkit is installed allow users in the wheel group to run anything.
    cat > ${NEWROOT}/etc/polkit-1/rules.d/void-live.rules <<_EOF
polkit.addAdminRule(function(action, subject) {
    return ["unix-group:wheel"];
});

polkit.addRule(function(action, subject) {
    if (subject.isInGroup("wheel")) {
        return polkit.Result.YES;
    }
});
_EOF
    chroot ${NEWROOT} chown polkitd:polkitd /etc/polkit-1/rules.d/void-live.rules
fi


sed -i "s,GETTY_ARGS=\"--noclear\",GETTY_ARGS=\"--noclear -a player\",g" ${NEWROOT}/etc/sv/agetty-tty1/conf

