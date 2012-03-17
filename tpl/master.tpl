<!doctype html>
<html>
<head> 
	<title>%($pageTitle%)</title>
	<link rel="stylesheet" type="text/css" href="/pub/style.css">
	<meta charset="utf-8"> 
</head> 
<body>
	<div id="header">
		<a href="http://suckless.org/">suckless.org</a> <span id="headerSubTitle">%($"siteTitle%)</span>
	</div>

	<div id="menu">
		<a href="http://suckless.org">home</a> |
		<a href="http://dwm.suckless.org">dwm</a> |
		<a href="http://st.suckless.org">st</a> |
		<a href="http://sta.li">stali</a> |
		<a href="http://surf.suckless.org">surf</a> |
		<a href="http://tools.suckless.org">tools</a> |
		<a href="http://man.suckless.org">man</a>
		<div class="right">
			<a href="http://dl.suckless.org">download</a> |
			<a href="http://hg.suckless.org">code</a>
		</div>
	</div>

	<div id="content">
% if(! ~ $#handlers_bar_left 0) {
	<div id="nav">
%   for(h in $handlers_bar_left) {
%       run_handler $$h
%   }
	</div>
% }

	<div id="main">

% run_handlers $handlers_body_head

% run_handler $handler_body_main

% run_handlers $handlers_body_foot

	</div>

	</div>

	<div id="footer">
	<div class="left">
	<a href="http://hg.suckless.org/swerc">swerc powered</a>
	</div>
	<div class="right">
	&copy; 2006-2012 suckless.org community
	</div>
	</div>
</body>
</html>
