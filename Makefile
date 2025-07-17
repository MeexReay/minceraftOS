.PHONY: build clean
	
build: data/mine
	docker image rm minceraftos-void | true
	docker build -t minceraftos-void .
	docker run --rm --cap-add=CAP_SYS_ADMIN -v $(CURDIR):/mnt/workdir -w /mnt/workdir minceraftos-void

data/mine:
	./mkmine

clean:
	rm -rf data/mine
	rm -rf build
