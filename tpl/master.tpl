<!doctype html>
<html>
<head> 
	<title>%($pageTitle%)</title>
	<link rel="stylesheet" type="text/css" href="/pub/style.css">
	<meta charset="utf-8"> 
</head> 
<body>
	<div id="header">
		<a href="/"><img src="//suckless.org/logo.svg" /></a>
		<a id="headerLink" href="/">%($"siteTitle%)</a> <span id="headerSubtitle">%($"siteSubtitle%)</span>
	</div>

	<div id="menu">
		<span class="left">
% if(~ $site 'suckless.org') {
		<a class="thisSite" href="//suckless.org">home</a>
% }
% if not {
		<a href="//suckless.org">home</a>
% }
% if(~ $site 'dwm.suckless.org') {
		<a class="thisSite" href="//dwm.suckless.org">dwm</a>
% }
% if not {
		<a href="//dwm.suckless.org">dwm</a>
% }
% if(~ $site 'st.suckless.org') {
		<a class="thisSite" href="//st.suckless.org">st</a>
% }
% if not {
		<a href="//st.suckless.org">st</a>
% }
% if(~ $site 'core.suckless.org') {
		<a class="thisSite" href="//core.suckless.org">core</a>
% }
% if not {
		<a href="//core.suckless.org">core</a>
% }
% if(~ $site 'sta.li') {
		<a class="thisSite" href="//sta.li">stali</a>
% }
% if not {
		<a href="//sta.li">stali</a>
% }
% if(~ $site 'surf.suckless.org') {
		<a class="thisSite" href="//surf.suckless.org">surf</a>
% }
% if not {
		<a href="//surf.suckless.org">surf</a>
% }
% if(~ $site 'tools.suckless.org') {
		<a class="thisSite" href="//tools.suckless.org">tools</a>
% }
% if not {
		<a href="//tools.suckless.org">tools</a>
% }
% if(~ $site 'libs.suckless.org') {
		<a class="thisSite" href="//libs.suckless.org">libs</a>
% }
% if not {
		<a href="//libs.suckless.org">libs</a>
% }
		</span>
		<span class="right">
			<a href="//dl.suckless.org">download</a>
			<a href="//git.suckless.org">source</a>
		</span>
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
	<span class="right">
	&copy; 2006-2017 suckless.org community | <a href="//ev.suckless.org/impressum">Impressum</a> | <a href="//ev.suckless.org">e.V.</a>
	</span>
	</div>
</body>
</html>
