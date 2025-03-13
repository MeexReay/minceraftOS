# minceraftOS

OS that uses Minceraft as Desktop Environment. \
Now it only starts minceraft and do nothing. 


## How to make iso file

You need to do this from Void Linux (because the script needs XBPS to build)!

Load minceraft assets at first:

```
./data/minceraft/UltimMC -l 1.21.4 # close minecraft when it's loaded
cp data/minceraft/ultimmc.cfg.def data/minceraft/ultimmc.cfg
```

Use `mkmine.sh` script to make ISO file. 
Result will be in `output/` directory.

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
