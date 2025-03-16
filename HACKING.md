# How to add extra mods

Important: we use Fabric Loader by default, if you want to change it to another one, read [section below](https://github.com/MeexReay/minceraftOS/blob/main/HACKING.md#how-to-change-mc-version-or-loader).

## Building mod from source

If you want to build them from source, just add new directory with `build.sh` script to `mods/`

Example of build.sh:
```bash
#!/bin/bash

./gradlew build 
# build jar file

mv build/libs/*.jar ../build 
# move jar file to mods/build/
```

## Add an already built mod

To add any mod you want, just add this line to `mods/build-all.sh`

If you have downloading link:
```bash
wget https://example.com/path/to/your-mod.jar
```

If your jar is in some dir:
```bash
cp /path/to/your-mod.jar .
```

# How to change MC version or loader

To change version or loader of Minceraft, edit `mine-data/mmc-pack.json` file.
You can generate it with MultiMC or PrismLauncher, and just copy.
If you are changing the loader, you might also want to remove existing fabric mods, they are located in the `mods/` folders. 

# How to change my nickname

UltimMC's nickname is stored in `run_mine.sh` file. Just change it from Steve to your one.

# Finally

Finally, after all the changes, build the ISO by [this guide](https://github.com/MeexReay/minceraftOS/blob/main/BUILD.md)
