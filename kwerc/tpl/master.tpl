<!DOCTYPE html>
<html>
    <head>
        <title>%($app%)</title>

        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
%{
        # Display `throw`n errors
        if {! isempty $notice} {
            echo '<div class="notice">'$notice'</div>'
        }

        # Do the thing!
        $handler_body
%}
    </body>
</html>
