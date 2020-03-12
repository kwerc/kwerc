# these lines were initially in initial.es. they were moved to a new
# file to be able to cat other files to the end of initial.es (renamed
# system.es now).

#	noexport lists the variables that are not exported.  It is not
#	exported, because none of the variables that it refers to are
#	exported. (Obviously.)  apid is not exported because the apid value
#	is for the parent process.  pid is not exported so that even if it
#	is set explicitly, the one for a child shell will be correct.
#	Signals are not exported, but are inherited, so $signals will be
#	initialized properly in child shells.  bqstatus is not exported
#	because it's almost certainly unrelated to what a child process
#	is does.  fn-%dispatch is really only important to the current
#	interpreter loop.

noexport = $noexport pid signals apid bqstatus fn-%dispatch path home
noexport = $noexport version mveetyrev options
noexport = $noexport corelib fn-old-background fn-new-background
noexport = $noexport panic dprint
noexport = $noexport enable-import import-core-lib import-user-lib import

#
# Title
#

#	This is silly and useless, but whatever value is returned here
#	is printed in the header comment in initial.c;  nobody really
#	wants to look at initial.c anyway.

result es initial state built in `/bin/pwd on `/bin/date for $version
