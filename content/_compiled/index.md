
<% contents_home = @items.find { |i| i.reps[0].path == '/contents/' } %>

<%= compileBook (contents_home) %>
