% if {~ $^debug true} {
<form method="POST" name="prompt">
    <input size="80" type="text" name="command" value="%($^post_arg_command%)">
    <input type="submit" Value="Run">
</form>
<script language="javascript">
    document.prompt.command.focus()
</script>

%{
if {! ~ $#post_arg_command 0 && ! ~ $^post_arg_command ''} {
    echo '<hr><pre>'
    es -xc $post_arg_command | escape_html |[2] $awk '{print "<b>"$0"</b>"}'
    echo '</pre>'
}
%}
% }
