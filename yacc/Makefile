# yacc - yacc unix port from plan9
# Depends on ../lib9

TARG      = yacc

OFILES    ?= ${TARG}.o
MANFILE   ?= ${TARG}.1

include ../config.mk

all: ${TARG}
#	@strip ${TARG}
	@echo built ${TARG}

install: ;
uninstall: ;

.c.o:
	@echo CC $*.c
	@${CC} ${CFLAGS} -I../lib9 -I../lib9/sec $*.c

clean:
	rm -f ${OFILES} ${TARG}

${TARG}: ${OFILES}
	@echo LD ${TARG}
	@${CC} ${LDFLAGS} -o ${TARG} ${OFILES} -L../lib9 -l9 -lm
