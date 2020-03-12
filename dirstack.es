#!/usr/local/bin/es
options = $options dirstack

dirstack = ()

fn dirs {
	if {! ~ $#dirstack 0 } {
		echo $dirstack
	}
}

fn pushd dir {
	if {! ~ $#dir 0} {
		let(cwd = `{pwd} ; okay = <={access -x -1 $dir}) {
			if {! ~ $#okay 0} {
				dirstack = $cwd $dirstack
				cd $dir
			} {
				echo 'pushd: could not access directory '^$dir
			}
		}
	} {
		echo 'usage: pushd [dir]'
	}
}

fn popd {
	if {! ~ $#dirstack 0} {
		todir = $dirstack(1)
		dirstack = $dirstack(2 ...)
		cd $todir
	}
}

noexport = $noexport dirstack fn-dirs fn-pushd fn-popd

