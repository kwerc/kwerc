export
CC		:= musl-gcc
LDFLAGS		:= -static
PREFIX		:= $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
MANPREFIX	:= $(PREFIX)/man
YACC		:= $(PREFIX)/vendor/yacc/oyacc
EDIT		:= null

all: yacc es sbase mawk cgd redli

yacc:
	cd vendor/yacc && ./configure
	$(MAKE) -C vendor/yacc

es: yacc
	cd vendor/es && ./configure --bindir $(PREFIX)/bin --mandir $(MANPREFIX)
	$(MAKE) -C vendor/es install

sbase:
	$(MAKE) -C vendor/sbase CC=$(CC) LDFLAGS=$(LDFLAGS) PREFIX=$(PREFIX) MANPREFIX=$(MANPREFIX) install

mawk:
	touch vendor/mawk/array.c vendor/mawk/array.h vendor/mawk/parse.c vendor/mawk/parse.h
	cd vendor/mawk && ./configure --prefix=$(PREFIX) --mandir=$(MANPREFIX)
	$(MAKE) -C vendor/mawk install

cgd:
	cd vendor/cgd && go build -ldflags "-linkmode external -extldflags -static"
	mkdir -p $(PREFIX)/bin && cp vendor/cgd/cgd $(PREFIX)/bin/

redli:
	cd vendor/redli && go build -ldflags "-linkmode external -extldflags -static"
	mkdir -p $(PREFIX)/bin && cp vendor/redli/redli $(PREFIX)/bin/

clean:
	$(MAKE) -C vendor/yacc clean
	rm $(PREFIX)/bin/es $(PREFIX)/bin/esdebug $(MANPREFIX)/man1/es.1
	$(MAKE) -C vendor/es PREFIX=$(PREFIX) MANPREFIX=$(MANPREFIX) clean
	$(MAKE) -C vendor/sbase PREFIX=$(PREFIX) MANPREFIX=$(MANPREFIX) uninstall clean
	$(MAKE) -C vendor/mawk uninstall clean
	rm $(PREFIX)/bin/cgd; cd vendor/cgd && go clean
	rm $(PREFIX)/bin/redli; cd vendor/redli && go clean
