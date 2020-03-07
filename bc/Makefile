# bc - bc unix port from plan9
# Depends on ../lib9

TARG      = bc
OFILES	  = y.tab.o
YFILES	  = bc.y
MANFILES  = bc.1

include ../yacc.mk

# Solaris
#LDFLAGS += -dy -lxnet

pre-uninstall:
	rm -f ${DESTDIR}${PREFIX}/lib/bclib

post-install:
	@mkdir -p ${DESTDIR}${PREFIX}/lib
	@cp bclib ${DESTDIR}${PREFIX}/lib/
