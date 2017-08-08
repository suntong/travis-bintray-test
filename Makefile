NAME    ?= john
VERSION ?= 0.0.0

all: test

clean: cleanbuild cleanpkg
cleanbuild:
	rm -fr ./build
cleanpkg:
	rm -fr ./pkg

test:
	go test -ldflags "-X main.name=${NAME}"

build: build/${NAME}/hello
build/%/hello:
	mkdir -p build/$*
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -a -installsuffix cgo -ldflags "-X main.name=$*" -o build/$*/hello

pkg: build pkg/${NAME}.deb
pkg/%.deb:
	mkdir -p ./pkg
	fpm -s dir -t deb \
		--name hello-${NAME} \
		--package ./pkg/${NAME}.deb \
		--force \
		--category admin \
		--deb-compression bzip2 \
		--url "${PKG_URL}" \
		--description "${PKG_DESC}" \
		--maintainer "${PKG_MAINT}" \
		--license "${PKG_LICNS}" \
		--version ${VERSION} \
		--architecture amd64 \
		--depends apt \
		./build/${NAME}/=/usr/bin/
