# yacc.mk - included by all Makefiles in subdirs which depend on yacc

include ../config.mk

all:
	@if [ ! -f y.tab.c ]; then \
	make -f Makefile depend;\
	fi
	@make -f Makefile ${TARG}
	@echo built ${TARG}


depend:
	@echo YACC ${YFILES}
	@${YACC} -d ${YFILES}

install: install-default post-install

install-default: ${TARG}
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f ${TARG} ${DESTDIR}${PREFIX}/bin/
	@chmod 755 ${DESTDIR}${PREFIX}/bin/${TARG}
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
	@cp -f ${MANFILES} ${DESTDIR}${MANPREFIX}/man1
	@chmod 444 ${DESTDIR}${MANPREFIX}/man1/${MANFILES}

uninstall: pre-uninstall
	rm -f ${DESTDIR}${PREFIX}/bin/${TARG}
	rm -f ${DESTDIR}${MANPREFIX}/man1/${MANFILES}

.c.o:
	@echo CC $*.c
	@${CC} ${CFLAGS} -I../lib9 -I../lib9 $*.c

clean:
	rm -f ${OFILES} ${TARG} y.tab.c y.tab.h

${TARG}: ${OFILES}
	@echo LD ${TARG}
	@${CC} ${LDFLAGS} -o ${TARG} ${OFILES} -L../lib9 -l9 -lm
