# 9base - Plan 9 userland for Unix

include config.mk

SUBDIRS  = lib9\
	yacc\
	ascii\
	awk\
	basename\
	bc\
	cal\
	cat\
	cleanname\
	cmp\
	date\
	dc\
	du\
	dd\
	diff\
	echo\
	ed\
	factor\
	fortune\
	fmt\
	freq\
	getflags\
	grep\
	hoc\
	join\
	listen1\
	look\
	ls\
	md5sum\
	mk\
	mkdir\
	mtime\
	pbd\
	primes\
	rc\
	read\
	rm\
	sam\
	sha1sum\
	sed\
	seq\
	sleep\
	sort\
	split\
	ssam\
	strings\
	tail\
	tee\
	test\
	touch\
	tr\
	troff\
	unicode\
	uniq\
	unutf\
	urlencode\
	wc

all:
	@echo 9base build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"
	@chmod 755 yacc/9yacc
	@for i in ${SUBDIRS}; do cd $$i; ${MAKE} || exit; cd ..; done;

clean:
	@for i in ${SUBDIRS}; do cd $$i; ${MAKE} clean || exit; cd ..; done
	@rm -f 9base-${VERSION}.tar.gz
	@echo cleaned 9base

install: all
	@for i in ${SUBDIRS}; do cd $$i; ${MAKE} install || exit; cd ..; done
	@echo installed 9base to ${DESTDIR}${PREFIX}

uninstall:
	@for i in ${SUBDIRS}; do cd $$i; ${MAKE} uninstall || exit; cd ..; done
	@echo uninstalled 9base

dist: clean
	@mkdir -p 9base-${VERSION}
	@cp -R Makefile README LICENSE std.mk yacc.mk config.mk ${SUBDIRS} 9base-${VERSION}
	@tar -cf 9base-${VERSION}.tar 9base-${VERSION}
	@gzip 9base-${VERSION}.tar
	@rm -rf 9base-${VERSION}
	@echo created distribution 9base-${VERSION}.tar.gz
