#!/usr/local/bin/es

fn %background cmd {
	let (pid = <={$&background $cmd}) {
		if {%is-interactive} {
			cmds = `` (' ' '{' '}') (echo $cmd)
			echo $cmds(1)^': '^$pid >[1=2]
		}
		apid = pid
	}
}

