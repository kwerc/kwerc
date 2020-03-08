export
CC		:= musl-gcc
LDFLAGS		:= -static
OBJTYPE		:= x86_64
PREFIX		:= $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
MANPREFIX	:= $(PREFIX)/man

all: 9base-rc sbase mawk cgd redli

9base-rc:
	$(MAKE) -C vendor/9base-rc CC=$(CC) LDFLAGS=$(LDFLAGS) OBJTYPE=$(OBJTYPE) PREFIX=$(PREFIX) MANPREFIX=$(MANPREFIX) install

sbase:
	$(MAKE) -C vendor/sbase CC=$(CC) LDFLAGS=$(LDFLAGS) PREFIX=$(PREFIX) MANPREFIX=$(MANPREFIX) install

mawk:
	touch vendor/mawk/array.c vendor/mawk/array.h
	cd vendor/mawk && ./configure --prefix=$(PREFIX) --mandir=$(MANPREFIX)
	$(MAKE) -C vendor/mawk install

cgd:
	cd vendor/cgd && go build -ldflags "-linkmode external -extldflags -static"
	mkdir -p $(PREFIX)/bin && cp vendor/cgd/cgd $(PREFIX)/bin/

redli:
	cd vendor/redli && go build -ldflags "-linkmode external -extldflags -static"
	mkdir -p $(PREFIX)/bin && cp vendor/redli/redli $(PREFIX)/bin/

clean:
	$(MAKE) -C vendor/9base-rc PREFIX=$(PREFIX) MANPREFIX=$(MANPREFIX) uninstall clean
	$(MAKE) -C vendor/sbase PREFIX=$(PREFIX) MANPREFIX=$(MANPREFIX) uninstall clean
	$(MAKE) -C vendor/mawk uninstall clean
	rm $(PREFIX)/bin/cgd; cd vendor/cgd && go clean
	rm $(PREFIX)/bin/redli; cd vendor/redli && go clean
