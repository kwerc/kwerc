#!/usr/local/bin/es
options = $options lc

# lc.es -- convenience for plan 9 users

fn lc {
	catch @ e { } {
		let( true = <={true} ; false = <={false}
			line-output = $false
			stream-output = $false
			sort-files = $true
			helpme = $false
			ofiles = ''
			files = *
			sortedfiles = '') {
			sortedfiles = `{ { for(i = $files) { echo $i } } | sort }
			for(x = $*){
				if {~ $x '-m' } { stream-output = $true ; break }
				if {~ $x '-C' } { line-output = $true ; break }
				if {~ $x '-f' } { sort-files = $false }
				if {~ $x '-h' } { helpme = $true ; break }
			}
			if {~ $helpme $true } {
				echo 'usage: lc -[f] -[mCh]'
				echo '       f -- do not sort filenames'
				echo '       C -- no column output'
				echo '       m -- stream output'
				echo '       h -- show this message'
				return 0
			}
			if {~ $sort-files $true} { ofiles = $sortedfiles } { ofiles = $files }
			if {~ $line-output $true} { for(i = $ofiles) { echo $i }  ; return 0 }
			if {~ $stream-output $true} { for(i = $ofiles) { echo -n $i ; echo -n ', ' }; echo '' ; return 0 }
			# otherwise print out a block of files
			echo $ofiles
		}
	}
}

