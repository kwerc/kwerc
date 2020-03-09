export
CC		:= musl-gcc
LDFLAGS		:= -static
PREFIX		:= $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
MANPREFIX	:= $(PREFIX)/man
YACC		:= $(PREFIX)/vendor/yacc/oyacc
EDIT		:= null

all: yacc rc sbase mawk cgd redli

yacc:
	cd vendor/yacc && ./configure
	$(MAKE) -C vendor/yacc

rc: yacc
	$(MAKE) -C vendor/rc CC=$(CC) LDFLAGS=$(LDFLAGS) PREFIX=$(PREFIX) MANPREFIX=$(MANPREFIX) YACC=$(YACC) EDIT=$(EDIT) install

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
	rm $(PREFIX)/bin/rc $(MANPREFIX)/man1/rc.1
	$(MAKE) -C vendor/rc PREFIX=$(PREFIX) MANPREFIX=$(MANPREFIX) clean
	$(MAKE) -C vendor/sbase PREFIX=$(PREFIX) MANPREFIX=$(MANPREFIX) uninstall clean
	$(MAKE) -C vendor/mawk uninstall clean
	rm $(PREFIX)/bin/cgd; cd vendor/cgd && go clean
	rm $(PREFIX)/bin/redli; cd vendor/redli && go clean
