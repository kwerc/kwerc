<!doctype html>
<html>
<head> 
	<title>%($pageTitle%)</title>
	<link rel="stylesheet" type="text/css" href="/pub/style.css">
	<meta charset="utf-8"> 
</head> 
<body>
	<div id="header">
		<a href="/">%($"siteTitle%)</a> <span id="headerSubtitle">%($"siteSubtitle%)</span>
	</div>

	<div id="menu">
% if(~ $site 'suckless.org') {
		<a class="thisSite" href="http://suckless.org">home</a>
% }
% if not {
		<a href="http://suckless.org">home</a>
% }
% if(~ $site 'dwm.suckless.org') {
		<a class="thisSite" href="http://dwm.suckless.org">dwm</a>
% }
% if not {
		<a href="http://dwm.suckless.org">dwm</a>
% }
% if(~ $site 'st.suckless.org') {
		<a class="thisSite" href="http://st.suckless.org">st</a>
% }
% if not {
		<a href="http://st.suckless.org">st</a>
% }
% if(~ $site 'sta.li') {
		<a class="thisSite" href="http://sta.li">stali</a>
% }
% if not {
		<a href="http://sta.li">stali</a>
% }
% if(~ $site 'surf.suckless.org') {
		<a class="thisSite" href="http://surf.suckless.org">surf</a>
% }
% if not {
		<a href="http://surf.suckless.org">surf</a>
% }
% if(~ $site 'tools.suckless.org') {
		<a class="thisSite" href="http://tools.suckless.org">tools</a>
% }
% if not {
		<a href="http://tools.suckless.org">tools</a>
% }
% if(~ $site 'man.suckless.org') {
		<a class="thisSite" href="http://man.suckless.org">man</a>
% }
% if not {
		<a href="http://man.suckless.org">man</a>
% }
		<div class="right">
			<a href="http://dl.suckless.org">download</a>
			<a href="http://hg.suckless.org">source</a>
			<a href="http://eyjafjallajoekull.com">art</a>
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
	<div class="right">
	&copy; 2006-2012 suckless.org community | <a href="http://garbe.us/Contact">Impressum</a>
	</div>
	</div>
</body>
</html>
