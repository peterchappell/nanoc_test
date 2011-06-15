
This is the table of contents page...

<% contents_home = @items.find { |i| i.reps[0].path == '/contents/' } %>
<ul class="toc">
<%= toc (contents_home) %>
</ul>
