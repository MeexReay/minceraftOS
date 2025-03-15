#!/bin/bash

start_path="$(pwd)"

function wrap_pwd {
  local was_path="$(pwd)"
  cd $start_path
  $@
  cd $was_path
}

function build_ultimmc {
  echo "Build UltimMC"
  if [ -f ultimmc/build/UltimMC ]; then
    return
  fi
  mkdir -p ultimmc/build
  cd ultimmc/build
  export JAVA_HOME=/usr/lib/jvm/openjdk8
  cmake \
	  -DCMAKE_C_COMPILER=/usr/bin/gcc \
	  -DCMAKE_CXX_COMPILER=/usr/bin/g++ \
	  -DCMAKE_BUILD_TYPE=Release \
	  -DLauncher_NOTIFICATION_URL:STRING=https://files.multimc.org/notifications.json \
	  -DCMAKE_INSTALL_PREFIX:PATH=../ \
	  -DLauncher_UPDATER_BASE=https://files.multimc.org/update/ \
	  -DLauncher_PASTE_EE_API_KEY:STRING=utLvciUouSURFzfjPxLBf5W4ISsUX4pwBDF7N1AfZ \
	  -DLauncher_ANALYTICS_ID:STRING=UA-87731965-2 \
	  -DLauncher_LAYOUT=lin-nodeps \
	  -DLauncher_BUILD_PLATFORM=lin64 \
	  -DLauncher_BUG_TRACKER_URL=https://github.com/UltimMC/Launcher/issues \
	  -DLauncher_EMBED_SECRETS=On \
	  ..
  make
}

function start_launcher {
  echo "Launcher is starting..."
  cd data/mine
  ./UltimMC -l default
}

function build_mods {
  echo "Mods are building..."
  cd mods
  ./build-all.sh
}

function copy_mine_data {
  echo "Minceraft data is copying..."
  cp mine-data/ultimmc.cfg data/mine
  cp mine-data/run_mine.sh data/mine
  cp mine-data/accounts.json data/mine
  cp -r mine-data/translations data/mine
  cp -r mine-data/themes data/mine
  cp -r mine-data/libraries data/mine
  cp -r mine-data/injectors data/mine
  cp -r mine-data/icons data/mine
  mkdir -p data/mine/instances
  mkdir -p data/mine/instances/default
  cp mine-data/mmc-pack.json data/mine/instances/default
  cp mine-data/instance.cfg data/mine/instances/default
  mkdir -p data/mine/instances/default/.minecraft
  cp mine-data/options.txt data/mine/instances/default/.minecraft
}
  
function create_mine_dir {
  echo "Create minceraft launcher directory..."
  mkdir data/mine || return
  wrap_pwd copy_mine_data
  wrap_pwd build_mods
  rm -rf data/mine/instances/default/.minecraft/mods
  cp -r mods/build data/mine/instances/default/.minecraft/mods
  wrap_pwd build_ultimmc
  cp -a ultimmc/build/. data/mine
  chmod 777 data/mine -R
  wrap_pwd start_launcher
  wrap_pwd copy_mine_data
}

rm -rf data/mine
create_mine_dir
echo "Minceraft is ready to play!"
