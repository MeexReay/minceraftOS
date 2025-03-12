# minceraftOS

It is a small OS without installation scripts and other bullshit, only minecraft on startup \
You just boot on it and play minceraft in offline mode

## How to make iso file

You need to do this from void linux!!1

```
cd /tmp
git clone https://github.com/MeexReay/minceraftOS
cd minceraftOS
./data/minceraft/UltimMC -l 1.21.4 # launches minecraft to test and download assets. close minecraft when it's loaded
cp data/minceraft/ultimmc.cfg.def data/minceraft/ultimmc.cfg
sudo ./mkmine.sh # idk why, if you can fix it, please make a PR
cd output
ls # here has to be the iso file
```

## How to burn it on disk

First link in google bro

```
sudo dd if=<input_file> of=<device_name>
```

## How to play minceraft

IDK bro just do what you want that's it
