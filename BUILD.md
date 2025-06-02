# How to build ISO file

> [!IMPORTANT]  
> Creating an ISO file requires to be Void Linux installed, if you dont want to install Void Linux, you should use [Docker](https://www.docker.com) (docker pull voidlinux/voidlinux).

## Preparing minceraft

At first, you need to prepare minceraft.

Minceraft preparing consists of 5 steps:

- Copying UltimMC configs to `data/mine` dir
- Building and copying mods to MC instance
- Compiling UltimMC from source (if you want to skip this step, you only need to copy built release of UltimMC to `ultimmc/build` directory)
- Downloading assets and libraries (just launches instance in online mode)
- Copying UltimMC configs again

Use `mkmine` to do all this automatically:

```bash
./mkmine

# IMPORTANT: if you get java selection window, choose Java 21
```

## Creating ISO file

Use `mkiso` script to create ISO file. Result will be in the `output/` directory.

Script compiles it only for x86_64, but I think it's not really hard to make it compile for any other architecture

This script only work on Void Linux (because it needs XBPS).

```bash
sudo ./mkiso

# idk why it needs sudo, please pr if you know how to remove it
```

## One-liner

Finally, you can forget all above and use just `[ -d data/mine ] || ./mkmine; sudo ./mkiso`
