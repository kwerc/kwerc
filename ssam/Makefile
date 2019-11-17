# ssam - stream interface for sam
# Depends on ../lib9

include ../config.mk

all:
	@echo built ssam

install:
	@cp -f ssam ${DESTDIR}${PREFIX}/bin/
	@chmod 755 ${DESTDIR}${PREFIX}/bin/ssam
	@cp -f ssam.1 ${DESTDIR}${MANPREFIX}/man1/
	@chmod 444 ${DESTDIR}${MANPREFIX}/man1/ssam.1

uninstall:
	@rm -f ${DESTDIR}${PREFIX}/bin/ssam
	@rm -f ${DESTDIR}${MANPREFIX}/man1/ssam.1

clean:
	@true

