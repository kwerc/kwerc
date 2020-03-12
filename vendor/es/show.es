#!/usr/local/bin/es
options = $options show

# a little something from OpenVMS:
# show is an internal that displays various variables and parameters.
# it can be easily extended by making a function named show-fnname

fn addshowfn n {
	showfns = $showfns $n
}

fn show-options {
	echo $options
}
showfns = options

fn show-debugging {
	echo $#debugging
}
addshowfn debugging

fn show-version {
	echo $version
}
addshowfn version

fn show-esversion {
	echo <={ $&version }
}
addshowfn esversion

fn show-primitives {
	echo <={ $&primitives }
}
addshowfn primitives

fn show-internals {
	echo <={ $&internals }
}
addshowfn internals

fn show-libraries {
	echo 'system: '^$^corelib
	echo 'user: '^$^libraries
}
addshowfn libraries

fn show-home {
	echo $home
}
addshowfn home

fn show-path {
	echo $path
}
addshowfn path

fn show-flags {
	echo 'usebg='^$usebg
	echo 'enable-import='^$enable-import
}
addshowfn flags

fn show-vars {
	let (private = false) {
		for(i = $*) {
			if {~ $i -p} {private = true}
		}
		if {$private} { vars -v -p } { vars -v }
	}
}
addshowfn vars

fn show-fns {
	let (private = false) {
		for(i = $*) {
			if {~ $i -p} {private = true}
		}
		if {$private} { vars -f -p } { vars -f }
	}
}
addshowfn fns

fn show-settors {
	let (private = false) {
		for(i = $*) {
			if {~ $i -p} {private = true}
		}
		if {$private} { vars -s -p } { vars -s }
	}
}
addshowfn settors

fn show-help {
	echo 'Commands available: '
	echo -n '    '
	echo $showfns
}
addshowfn help

fn show cmd rest {
	let(showcmd = '') {
		if {! ~ $#cmd 1} {
			show help
		} {
			showcmd = 'show-'^$cmd
			fnshowcmd = 'fn-'^$showcmd
			dprint 'showcmd = '^$showcmd
			$showcmd $rest
		}
	}
}

for(i = $showfns) {
	noexport = $noexport 'fn-show-'^$i
}
noexport = $noexport fn-addshowfn fn-show showfns
