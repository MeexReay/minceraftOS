# minceraftOS

OS that uses Minceraft as a Desktop Environment. \
Now it only starts minceraft and does nothing.

## How to make ISO file

### Preparing minceraft

At first, you need to prepare minceraft.

Minceraft preparing consists of 5 steps:

- Copying UltimMC configs to `data/mine` dir
- Building and copying mods to MC instance
- Compiling UltimMC from source (if you want to skip this step, you only need to copy built release of UltimMC to `ultimmc/build` directory)
- Downloading assets and libraries (just launches instance in online mode)
- Copying UltimMC configs again

Use `mkmine` to do all this automatically:

```
./mkmine

# IMPORTANT: if you get java selection window, choose Java 21
```

### Creating ISO file

Use `mkiso` script to create ISO file. Result will be in `output/` directory.

Script compiles it only for x86_64, but I think it's not really hard to make it compile for any other architecture

This script only work on Void Linux (because it needs XBPS).

```
sudo ./mkiso

# idk why it needs sudo, please pr if you know how to remove it
```

### One-liner

Finally, you can forget all above and use just `[ -d data/mine ] || ./mkmine.sh; sudo ./mkiso.sh`

## How to burn ISO to disk

To burn live-cd iso to disk use:

```
sudo dd if=/path/to/minceraftOS.iso of=/dev/<disk_id> status=progress
```

To find out your `<disk_id>` (ex. sda), use `lsblk` or `fdisk -l`

Now there is no read-write mode, only live-cd

## How to use

IDK bro just do what you want that's it \
You can use creative worlds as workspaces, books as files and chests as directories XD. \
Maybe one day there will be a terminal blocks that can run commands and start xorg windows!

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
