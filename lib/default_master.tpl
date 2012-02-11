	<div id="menu">
		<a href="http://suckless.org">home</a> |
		<a href="http://hg.suckless.org">code</a> |
		<a href="http://dl.suckless.org">download</a> |
		<a href="http://man.suckless.org">man</a> |
		<a href="http://dwm.suckless.org">dwm</a> |
		<a href="http://libs.suckless.org">libs</a> |
		<a href="http://st.suckless.org">st</a> |
		<a href="http://sta.li">stali</a> |
		<a href="http://surf.suckless.org">surf</a> |
		<a href="http://tools.suckless.org">tools</a> |
		<a href="http://wmi.suckless.org">wmi</a>
	</div>
	<div id="header">
% if(! ~ $#siteImage 0) {
	<a href="/"><img src="%($"siteImage%)" alt="%($"siteTitle%)"/> <span id="headerSubTitle">%($"siteSubTitle%)</span></a>
% }
% if not {
	<a href="/">%($"siteTitle%) <span id="headerSubTitle">%($"siteSubTitle%)</span></a>
% }
	</div>

	<div id="content">
% if(! ~ $#handlers_bar_left 0) {
	<div id="nav">
%   for(h in $handlers_bar_left) {
%       run_handler $$h
%   }
	</div>
% }

	<div id="ads">
	</div>
	<div id="main">

% run_handlers $handlers_body_head

% run_handler $handler_body_main

% run_handlers $handlers_body_foot

	</div>

	</div>

	<div id="footer">
	<div class="left">
	<a href="http://werc.cat-v.org/">Powered by werc</a>
	</div>
	<div class="right">
	&copy; 2006-2012 suckless.org community
	</div>
	</div>
