fn redis {
    rout=`{redli -h $redis_host -p $redis_port -a $redis_password}
}

fn rcedis {
    cmd=$1
    shift
    rcedis_$cmd $*
}

fn rcedis_lolwut {
    echo LOLWUT | redis
    echo $rout
}
