<!DOCTYPE html>
<html>
<head> 
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    %($"extra_headers%)
</head> 
<body>
% run_handlers $handlers_body_head
% run_handler $handler_body_main
% run_handlers $handlers_body_foot
</body>
</html>
