# minceraftOS

OS that uses Minceraft as a Desktop Environment. \
Now it only starts minceraft and does nothing.

## How to make iso file

You need to do this from Void Linux (because the script needs XBPS to build)!

At first, compile ultimmc and load minceraft assets:

```
make ultimmc

# it will start game to load assets,
# you just need to close the window when it will open
```

Use `mkmine.sh` script to make ISO file. \
Result will be in `output/` directory. \
Script compiles it only for x86_64, but I think it's not really hard to make it compile for any other architecture

```
sudo ./mkmine.sh
sudo make iso # the same but also prepares launcher

# idk why it needs sudo, please pr if you know how to remove it
```

Finally, you can forget all above and use just `sudo make`

## How to burn it on disk

To burn iso:

```
sudo dd if=/path/to/minceraftOS.iso of=/dev/<disk_id> status=progress
```

Use `lsblk` to find out your `disk_id` (ex. sda)

## How to use

IDK bro just do what you want that's it \
You can use creative worlds as workspaces, books as files and chests as directories XD. \
Maybe one day there will be a terminal blocks that can run commands and start xorg windows!
