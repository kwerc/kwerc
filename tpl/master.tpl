<!doctype html>
<html>
<head> 
    <title>%($site_title%)</title>
    <link rel="icon" href="/favicon.png" type="image/png" />

    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

% if(! ~ $#meta_description 0) {
    <meta name="description" content="%($meta_description%)">
% }
% if(! ~ $#meta_keywords 0) {
    <meta name="keywords" content="%($meta_keywords%)">
% }

    %($"extra_headers%)
</head> 
<body>
% run_handlers $handlers_body_head
% run_handler $handler_body_main
% run_handlers $handlers_body_foot
</body>
</html>
