# Optional dependency; you'll need to install a markdown parser if you want this.
fn md_handler { markdown $1 }

fn tpl_handler { template $* }

fn html_handler {
    # body states: 0 = no <body> found, 2 = after <body>, 1 = after <body></body>, -1 = after </body>
    $awk 'gsub(".*<[Bb][Oo][Dd][Yy][^>]*>", "") > 0 {body=2}
         gsub("</ *[Bb][Oo][Dd][Yy][^>]*>.*", "") > 0 {print; body=body-1}
         body==2 {print}
         body==0 {buf=buf "\n" $0}
         END {if(body<=0) {print buf}}' < $1
}

fn txt_handler {
    # Note: Words are not broken, even if they are way beyond 80 chars long
    echo '<pre>'
    sed 's/</\&lt;/g; s/>/\&gt;/g' < $1
    echo '</pre>'
}

fn dir_listing_handler {
    if {~ $1 */} {
        d=`{echo $1 | sed 's,/$,,'}
    } {
        d=`{dirname $1}
    }
    if {~ $#d 0} { d='/' }
    echo $d|sed 's,.*//,,g; s,/$,,; s,/, / ,g; s/[\-_]/ /g; s,.*,<h1 class="dir-list-head">&</h1> <ul class="dir-list">,'
    # Symlinks suck: '/.' forces ls to list the linked dir if $d is a symlink.
    ls -F $dir_listing_ls_opts $sitedir$d/. | sed $dirfilter$dirclean | $awk '{match($0, "/[^/]*/?$"); l=substr($0, RSTART+1, RLENGTH-1);n=l; gsub(/[\-_]/, " ", n); print "<li><a href=\""l"\">"n"</a></li>"; }' | uniq
    echo '</ul>'
}

fn setup_handlers {
    if {test -f $local_path.md} {
        local_file=$local_path.md
        handler_body_main=(md_handler $local_file)
    } {test -f $local_path.tpl} {
        local_file=$local_path.tpl
        handler_body_main=(tpl_handler $local_file)
    } {test -f $local_path.html} {
        local_file=$local_path.html
        handler_body_main=(html_handler $local_file)
    } {test -f tpl^$req_path^.tpl} {
        handler_body_main=(tpl_handler tpl^$req_path^.tpl)
    } {test -f $local_path.txt} {
        local_file=$local_path.txt
        handler_body_main=(txt_handler $local_file)
    }

    if {! ~ $#handler_body_main 0} {
        # We are done
    } {~ $local_path */index} {
        handler_body_main=(dir_listing_handler $req_path)
        if {test -f $sitedir$req_path'_header.md'} {
            ll_add handlers_body_head md_handler $sitedir$req_path'_header.md'
        }
        if {test -f $sitedir$req_path'_footer.md'} {
            ll_add handlers_body_foot md_handler $sitedir$req_path'_footer.md'
        }
    } {~ $local_path *.html && test -f $local_path} {
        # Canonize explicit .html urls, the web server might handle this first!
        perm_redirect `{echo $req_path | sed 's/.html$//'}
    } {test -f $local_path} {
        static_file $local_path
    } {~ $req_path /static/* && test -f .$req_path} {
        static_file .$req_path
    } {
        setup_404_handler
    }
}

# This function allows config files to define their own 404 handlers.
fn setup_404_handler {
    handler_body_main=(tpl_handler `{get_tpl_file 404.tpl})
    echo 'Status: 404 Not Found'
    dprint 'NOT FOUND: '$^SERVER_NAME^$^REQUEST_URI^' - '^$^HTTP_REFERER^' - '^$^HTTP_USER_AGENT
}

fn run_handlers { for(h = $*) run_handler $$h }
fn run_handler { $*(1) $*(2-) }
