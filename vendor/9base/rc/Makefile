# rc - rc shell unix port from plan9
# Depends on ../lib9

TARG      = rc
OFILES    = code.o exec.o getflags.o glob.o here.o io.o lex.o \
            pcmd.o pfnc.o simple.o subr.o trap.o tree.o unixcrap.o \
            var.o y.tab.o plan9ish.o havefork.o
YFILES    = syn.y
MANFILES  = rc.1

include ../config.mk

# Solaris
#LDFLAGS   += -dy -lxnet

all:
	@if [ ! -f y.tab.c ]; then \
	make -f Makefile depend;\
	fi
	@make -f Makefile ${TARG}
	@echo built ${TARG}

depend:
	@echo YACC ${YFILES}
	@${YACC} -d ${YFILES}
	@cp y.tab.h x.tab.h

install: ${TARG}
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f ${TARG} ${DESTDIR}${PREFIX}/bin/
	@chmod 755 ${DESTDIR}${PREFIX}/bin/${TARG}
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
	@cp -f ${MANFILES} ${DESTDIR}${MANPREFIX}/man1
	@chmod 444 ${DESTDIR}${MANPREFIX}/man1/${MANFILES}
	@mkdir -p ${DESTDIR}${PREFIX}/etc
	@cp -f rcmain ${DESTDIR}${PREFIX}/etc
	@chmod 755 ${DESTDIR}${PREFIX}/etc/rcmain

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/${TARG}
	rm -f ${DESTDIR}${MANPREFIX}/man1/${MANFILES}
	rm -f ${DESTDIR}${PREFIX}/etc/rcmain

.c.o:
	@echo CC $*.c
	@${CC} ${CFLAGS} -I../lib9 -I${PREFIX}/include -I../lib9 $*.c

clean:
	rm -f ${OFILES} ${TARG} y.tab.c y.tab.h x.tab.h

${TARG}: ${OFILES}
	@echo LD ${TARG}
	@${CC} ${LDFLAGS} -o ${TARG} ${OFILES} -L${PREFIX}/lib -L../lib9 -l9 -lm
