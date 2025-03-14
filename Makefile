PHONY=build iso ultimmc clean

build: iso

clean:
	rm -rf output
	cp -r data/minceraft data/minceraft_tmp
	rm -rf data/minceraft
	mkdir data/minceraft
	cp data/minceraft_tmp/ultimmc.cfg.def data/minceraft
	cp -r data/minceraft_tmp/instances data/minceraft
	cp data/minceraft_tmp/run_mine.sh data/minceraft
	cp data/minceraft_tmp/accounts.json data/minceraft
	rm -rf data/minceraft_tmp
	rm -rf ultimmc/build

ultimmc: data/minceraft/UltimMC

data/minceraft/UltimMC:
	mkdir -p ultimmc/build
	export JAVA_HOME=/usr/lib/jvm/openjdk8 && cd ultimmc/build && cmake \
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
	cd ultimmc/build && make
	cp -a ultimmc/build/. data/minceraft/
	rm -rf ultimmc/build
	chmod 777 data/minceraft -R
	echo "CLOSE MINECRAFT WHEN ASSETS ARE LOADED!!"
	cp data/minceraft/ultimmc.cfg.def data/minceraft/ultimmc.cfg
	cd data/minceraft && ./UltimMC -o -n Steve -l 1.21.4
	cp data/minceraft/ultimmc.cfg.def data/minceraft/ultimmc.cfg

iso: data/minceraft/UltimMC
	sudo ./mkmine.sh
