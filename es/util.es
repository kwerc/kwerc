################################################################################
# CGI utils

fn dprint { echo $* >[1=2] }

fn escape_html { sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g' $* }

fn http_redirect {
    if {~ $1 http://* https://*} {
        t=$1
    } {~ $1 /*} {
        t=$^base_url^$1
    } {
        t=$^base_url^$^req_path^$1
    }
    echo 'Status: '^$2^'
Location: '^$t^'

'
    exit
}
fn perm_redirect { http_redirect $1 '301 Moved Permanantly' }
fn post_redirect { http_redirect $1 '303 See Other' }

# Note: should check if content type is application/x-www-form-urlencoded?
# Should compare with http://www.shelldorado.com/scripts/cmds/urlgetopt.txt
fn load_post_args {
    if {~ $REQUEST_METHOD POST && ~ $#post_args 0} {
        for(pair = `` \&\n {cat}) {
            pair=`` '=' {echo -n $pair}
            n='post_arg_'^`{echo $pair(1)|urldecode|tr -cd 'a-zA-Z0-9_'}
            post_args=( $post_args $n )
            $n=`` () {echo -n $pair(2)|urldecode|tr -d ''}
        }
        pair=()
    } {
        status='No POST or post args already loaded'
    }
}
# Status is () if at least one arg is found. DEPRECATED: access vars directly.
fn get_post_args {
    load_post_args
    _status='No post arg matches'
    for(n = $*) {
        v=post_arg_$n
        if {! ~ $#$v 0} {
            $n=$$v
            _status=()
        }
    }
    status=$_status
}

# This seems slightly improve performance, but might depend on httpd buffering behavior.
fn awk_buffer {
    $awk '
    {
        buf = buf $0"\n"
        if (length(buf) > 1400) {
            printf "%s", buf
            buf = ""
        }
    }
    END { printf "%s", buf }
    '
}

fn urldecode {
    $awk '
    BEGIN {
        hextab ["0"] = 0; hextab ["8"] = 8;
        hextab ["1"] = 1; hextab ["9"] = 9;
        hextab ["2"] = 2; hextab ["A"] = hextab ["a"] = 10;
        hextab ["3"] = 3; hextab ["B"] = hextab ["b"] = 11;
        hextab ["4"] = 4; hextab ["C"] = hextab ["c"] = 12;
        hextab ["5"] = 5; hextab ["D"] = hextab ["d"] = 13;
        hextab ["6"] = 6; hextab ["E"] = hextab ["e"] = 14;
        hextab ["7"] = 7; hextab ["F"] = hextab ["f"] = 15;
    }
    {
        decoded = ""
        i = 1
        len = length ($0)
        while ( i <= len ) {
            c = substr ($0, i, 1)
            if (c == "%") {
                if (i+2 <= len) {
                    c1 = substr ($0, i+1, 1)
                    c2 = substr ($0, i+2, 1)
                    if (hextab [c1] == "" || hextab [c2] == "") {
                        print "WARNING: invalid hex encoding: %" c1 c2 | "cat >&2"
                    } else {
                        code = 0 + hextab [c1] * 16 + hextab [c2] + 0
                        c = sprintf ("%c", code)
                        i = i + 2
                    }
                } else {
                    print "WARNING: invalid % encoding: " substr ($0, i, len - i)
                }
            } else if (c == "+") {
                c = " "
            }
            decoded = decoded c
            ++i
        }
        printf "%s", decoded
    }
    '
}

fn urlencode {
    $awk '
    BEGIN {
        # We assume an awk implementation that is just plain dumb.
        # We will convert an character to its ASCII value with the
        # table ord[], and produce two-digit hexadecimal output
        # without the printf("%02X") feature.

        EOL = "%0A" # "end of line" string (encoded)
        split ("1 2 3 4 5 6 7 8 9 A B C D E F", hextab, " ")
        hextab [0] = 0
        for (i=1; i<=255; ++i)
            ord [ sprintf ("%c", i) "" ] = i + 0
        if ("'^$^EncodeEOL^'" == "yes")
            EncodeEOL = 1
        else
            EncodeEOL = 0
    }
    {
        encoded = ""
        for (i=1; i<=length ($0); ++i) {
            c = substr ($0, i, 1)
            if (c ~ /[a-zA-Z0-9.-]/) {
                encoded = encoded c     # safe character
            } else if (c == " ") {
                encoded = encoded "+"   # special handling
            } else {
                # unsafe character, encode it as a two-digit hex-number
                lo = ord [c] % 16
                hi = int (ord [c] / 16);
                encoded = encoded "%" hextab [hi] hextab [lo]
            }
        }
        if (EncodeEOL) {
            printf ("%s", encoded EOL)
        } else {
            print encoded
        }
    }
    END {
        #if (EncodeEOL) print ""
    }
    ' $*
}

# Cookies
fn set_cookie {
    # TODO: should check input values more carefully
    name=$1
    val=$2
    extraHttpHeaders=( $extraHttpHeaders 'Set-cookie: '^$^name^'='^$^val^'; path=/;' )
}
fn get_cookie {
    co=`` ';' {echo $HTTP_COOKIE}

    # XXX: we might be adding a trailing new line?
    # The ' ?' is needed to deal with '; ' inter-cookie delimiter
    { for(c = $co) echo $c } | sed -n 's/^ ?'$1'=//p'
}

fn static_file {
    echo 'Content-Type: '`{select_mime $1}
    echo
    cat $1
    exit
}

fn select_mime {
    m='text/plain'
    if {~ $1 *.css} {
        m='text/css'
    } {~ $1 *.ico} {
        m='image/x-icon'
    } {~ $1 *.png} {
        m='image/png'
    } {~ $1 *.jpg *.jpeg} {
        m='image/jpeg'
    } {~ $1 *.gif} {
        m='image/gif'
    } {~ $1 *.pdf} {
        m='application/pdf'
    }
    echo $m
}

################################################################################
# rc utils

# Manage nested lists
fn ll_add {
    _l=$1^_^$#$1
    $_l=$*(2-)
    $1=( $$1 $_l )
}
# Add to the head: dangerous if you shrink list by hand!
fn ll_addh {
    _l=$1^_^$#$1
    $_l=$*(2-)
    $1=( $_l $$1 )
}

################################################################################
# Utils to be used from config files

fn conf_perm_redirect {
    if {~ $#* 1} {
        perm_redir_to=$1
    } {
        ll_addh perm_redir_patterns $1 $2
    }
}

fn get_tpl_file {
    cd $sitedir
    if {test -f _kwerc/tpl/$1} {
        file=$sitedir/_kwerc/tpl/$1
    }
    for(i = $args) {
        if {test -d $i} {
            cd $i
            if {test -f _kwerc/tpl/$1} {
                file=`{pwd}^/_kwerc/tpl/$1
            }
        }
    }
    cd $kwerc_root
    if {! ~ $#file 0} {
        echo -n $file
    } {test -f $sitedir/_kwerc/tpl/$1} {
        echo -n $sitedir/_kwerc/tpl/$1
    } {test -f tpl/$1.local} {
        echo -n tpl/$1.local
    } {test -f tpl/$1} {
        echo -n tpl/$1
    } {
        status='Can''t find tpl file: '$1
    }
}

fn template {
    $awk '
    function pr(str) {
        if (lastc !~ "[{(]")
            gsub(/''/, "''''", str)
        printf "%s", str
    }
    function trans(c) {
        printf "%s", end

        lastc = c
        end = "\n"
        if (c == "%")
            end = ""
        else if (c == "(")
            printf "echo -n "
        else if (c ~ "[})]") {
            end = "''\n"
            printf "echo -n ''"
        }
    }

    BEGIN {
        lastc = "{"
        trans("}")
    }
    END {
        print end
    }

    /^%/ && $0 !~ /^%[{()}%]/ && lastc !~ /[({]/ {
        trans("%")
        print substr($0, 2)
        next
    }
    {
        if (lastc == "%")
            trans("}")
        n = split($0, a, "%")
        pr(a[1])
        for (i=2; i<=n; i++) {
            c = substr(a[i], 1, 1)
            rest = substr(a[i], 2)

            if ((lastc !~ "[({]" && c ~ "[({]") ||
                (lastc == "{" && c == "}") ||
                (lastc == "(" && c == ")"))
                trans(c)
            else if (c == "%")
                pr("%")
            else
                pr("%" c)
            pr(rest)
        }
        pr("\n")
    }
    ' $* | es
}
