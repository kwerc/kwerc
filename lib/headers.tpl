<!doctype html>
<html>
<head> 
	<title>%($pageTitle%)</title>
% env > /tmp/x.txt
% style = `{get_cookie style}
% if(~ $"style 1) {
	<link rel="stylesheet" type="text/css" href="/pub/style1.css">
% }
% if not {
	<link rel="stylesheet" type="text/css" href="/pub/style.css">
% }
	<meta charset="utf-8"> 
</head> 
