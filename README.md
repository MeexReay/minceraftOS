# minceraftOS

OS that uses Minceraft as a Desktop Environment. \
Now it only starts minceraft and does nothing.

## Screenshots

Title Menu

![image](https://github.com/user-attachments/assets/6895b0e6-5770-4144-82e5-68b5c87284b2)

## How to use

IDK bro just do what you want that's it \
You can use creative worlds as workspaces, books as files and chests as directories XD. \
Maybe one day there will be a terminal blocks that could run commands and start xorg windows!

## How to burn ISO to disk

Precompiled images: [Latest release](https://github.com/MeexReay/minceraftOS/releases/latest)

To burn live-cd iso to disk use:

```bash
sudo dd if=/path/to/minceraftOS.iso of=/dev/<disk_id> status=progress
```

To find out your `<disk_id>` (ex. sda), use `lsblk` or `fdisk -l`

For now, there is no read-write mode, only live-cd

## How to build ISO file

One-liner: `[ -d data/mine ] || ./mkmine; sudo ./mkiso` \
Read more: [BUILD.md](https://github.com/MeexReay/minceraftOS/blob/main/BUILD.md) \
Modification: [HACKING.md](https://github.com/MeexReay/minceraftOS/blob/main/HACKING.md)

## Roadmap

- [ ] Change name of os everywhere
- [ ] Terminal emulator (monitor) block
- [ ] View xorg windows on monitor block
- [x] Disable TTY and install plymouth
- [x] Launch minceraft at startup
- [ ] Add color support to terminal emulator
- [x] Create minceraftOS logo
- [x] Add logo to game
- [ ] Add logo to plymouth
- [ ] Network settings in game settings
- [ ] Remove some options in game settings (fullscreen)
- [x] Make quit button shutdown computer
- [x] Add reboot button (idk where)
- [x] Remove realms button or maybe change it to something
- [ ] Make language in game changes locale
- [ ] Make autologin to root so it makes simple doing poweroff or reboot computer
- [ ] Remove squashfs (or make parameter that disables it)
