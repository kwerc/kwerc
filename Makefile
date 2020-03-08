export CC := musl-gcc -static -O3

all: 9base mawk cgd redli

9base:
	$(MAKE) -C vendor/9base

mawk:
	touch vendor/mawk/array.c vendor/mawk/array.h
	cd vendor/mawk && ./configure
	$(MAKE) -C vendor/mawk

cgd:
	cd vendor/cgd && go build -ldflags "-linkmode external -extldflags -static"

redli:
	cd vendor/redli && go build -ldflags "-linkmode external -extldflags -static"

install:
	mkdir -p bin
	for i in basename bc cat date du echo fmt grep ls mkdir mtime rc read rm sha1sum sed seq sleep sort split tail tee test touch tr uniq wc; do \
		cp vendor/9base/$$i/$$i bin/; \
	done
	for i in mawk cgd redli; do \
		cp vendor/$$i/$$i bin/; \
	done

uninstall:
	for i in basename bc cat date du echo fmt grep ls mkdir mtime rc read rm sha1sum sed seq sleep sort split tail tee test touch tr uniq wc mawk cgd redli; do \
		rm bin/$$i; \
	done

clean:
	$(MAKE) -C vendor/9base clean
	$(MAKE) -C vendor/mawk clean
	cd vendor/cgd && go clean
	cd vendor/redli && go clean
