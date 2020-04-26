export
CC		:= musl-gcc # note: 9base overrides (musl breaks some commands)
LDFLAGS		:= -static
OBJTYPE		:= x86_64
PREFIX		:= $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
MANPREFIX	:= $(PREFIX)/man
PLAN9		:= $(PREFIX)/vendor/9base
YACC		:= $(PREFIX)/vendor/9base/yacc/yacc -S
EDIT		:= null

all: 9base es mawk cgd bat redli

9base:
	$(MAKE) -C vendor/9base CC=cc LDFLAGS=$(LDFLAGS) OBJTYPE=$(OBJTYPE) PREFIX=$(PREFIX) MANPREFIX=$(MANPREFIX) install

es: 9base
	cd vendor/es && ./configure --bindir $(PREFIX)/bin --mandir $(MANPREFIX)
	$(MAKE) -C vendor/es install

mawk:
	touch vendor/mawk/array.c vendor/mawk/array.h vendor/mawk/parse.c vendor/mawk/parse.h
	cd vendor/mawk && ./configure --prefix=$(PREFIX) --mandir=$(MANPREFIX)
	$(MAKE) -C vendor/mawk install

cgd:
	cd vendor/cgd && go build -ldflags "-linkmode external -extldflags -static"
	mkdir -p $(PREFIX)/bin && cp vendor/cgd/cgd $(PREFIX)/bin/

bat:
	cd vendor/bat && go build -ldflags "-linkmode external -extldflags -static"
	mkdir -p $(PREFIX)/bin && cp vendor/bat/bat $(PREFIX)/bin/

redli:
	cd vendor/redli && go build -ldflags "-linkmode external -extldflags -static"
	mkdir -p $(PREFIX)/bin && cp vendor/redli/redli $(PREFIX)/bin/

clean:
	$(MAKE) -C vendor/9base PREFIX=$(PREFIX) MANPREFIX=$(MANPREFIX) uninstall clean
	rm $(PREFIX)/bin/es $(PREFIX)/bin/esdebug $(MANPREFIX)/man1/es.1
	$(MAKE) -C vendor/es PREFIX=$(PREFIX) MANPREFIX=$(MANPREFIX) clean
	$(MAKE) -C vendor/mawk uninstall clean
	rm $(PREFIX)/bin/cgd; cd vendor/cgd && go clean
	rm $(PREFIX)/bin/bat; cd vendor/bat && go clean
	rm $(PREFIX)/bin/redli; cd vendor/redli && go clean
