#!/path/to/kwerc/bin/es

path = (`{../../bin/pwd | ../../bin/sed 's,kwerc/es,bin,'})

. ./cgi.es
. ./util.es
. ./auth.es
cd ..

kwerc_root = `{pwd}
if {~ $HTTPS on} {
    base_url = https://$SERVER_NAME
} {
    base_url = http://$SERVER_NAME
}
req_path = `{echo -n $REQUEST_URI | sed 's/\?.*//; s!//+!/!g; s/%5[Ff]/_/g; s/[^a-zA-Z0-9_+\-\/\.,:]//g; s/\.\.*/./g; 1q'}
local_path = $kwerc_root/site$req_path
local_file = ''
master_template = tpl/master.tpl
REMOTE_ADDR = `{echo $REMOTE_ADDR | sed 's/\.[0-9]*\.[0-9]*$//'}^.xxx.xxx # anonymize IPs to first 2 octets
dateun = `{date -un}

if {test -f config} {
    . config
}

# Preload post args for templates where cgi's stdin is not accessible
if {~ $REQUEST_METHOD POST} {
    load_post_args
}
if {! isempty $QUERY_STRING} {
    load_query_args
}

# Do auth
if {~ $^p_logout yes || ~ $req_path /logout} {
    logout_user
} {
    try login_user
}

# Clean path
if {~ $req_path */index} {
    perm_redirect `{echo $req_path | sed 's,/index$,/,'}
}
if {~ $local_path */} {
    if {test -d $local_path} {
        local_path = $local_path^'index'
    } {ls `{basename -d $local_path}^* >/dev/null >[2=1]} {
        perm_redirect `{echo $req_path | sed 's,/+$,,'}
    }
} {~ $req_path *'.' *',' *';' *':'} {
    perm_redirect `{echo $req_path | sed 's/[.,;:)]$//'}
} {test -d $local_path} {
    perm_redirect $req_path^'/'
}

# Figure out how to handle this file
setup_handlers

# End of HTTP headers
echo 'Content-Type: text/html'$NEWLINE

# Log request
dprint $^SERVER_NAME^$^REQUEST_URI - $^HTTP_USER_AGENT - $^REQUEST_METHOD - $^handler_body - $^master_template

if {~ $REQUEST_METHOD HEAD} {
    exit
}

# The fun begins
template $master_template | awk_buffer
