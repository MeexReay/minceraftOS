# minceraftOS

OS that uses Minceraft as a Desktop Environment. \
Now it only starts minceraft and do nothing.

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

First link in google bro

```
sudo dd if=<input_file> of=<device_name> status=progress
```

## How to play minceraft

IDK bro just do what you want that's it
