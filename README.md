# minceraftOS

OS that uses Minceraft as Desktop Environment. \
Now it only starts minceraft and do nothing.

## Download iso file

You can get iso file of latest version here: [Latest release](https://github.com/MeexReay/minceraftOS/releases/latest)
But if you want to get all latest unstable changes and fixes, you need to build iso file yourself: [How to make iso file](https://github.com/MeexReay/minceraftOS#how-to-make-iso-file)

## How to make iso file

You need to do this from Void Linux (because the script needs XBPS to build)!

Load minceraft assets at first:

```
./data/minceraft/UltimMC -l 1.21.4 # close minecraft when it's loaded
cp data/minceraft/ultimmc.cfg.def data/minceraft/ultimmc.cfg
```

Use `mkmine.sh` script to make ISO file. \
Result will be in `output/` directory. \
Script compiles it only for x86_64, but I think it's not really hard to make it compile for any other architecture

```
sudo ./mkmine.sh # idk why it needs sudo, please pr if you know how to remove it
```

## How to burn it on disk

First link in google bro

```
sudo dd if=<input_file> of=<device_name> status=progress
```

## How to play minceraft

IDK bro just do what you want that's it
