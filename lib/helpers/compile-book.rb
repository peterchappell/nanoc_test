module CompileBookHelper
  def compileBook (page, levelCount=0, compiled_buffer='')

    # Clear for start
    compiled_buffer << "\t"

    # Add page
    if page[:type] == 'article'
        compiled_buffer << '

'+ '#'*levelCount + page[:title] + '

'
        compiled_buffer << page.raw_content.gsub(/#[#].?/,'######')
    end

    # Add children to sitemap, recursively
    visible_children = page.children.sort_by { |page| page[:order] }
    if visible_children.size > 0

      # Add children
      visible_children.each do |child|
        compileBook(child, levelCount+1, compiled_buffer)
      end

      # Close list
      compiled_buffer << "\t"

    end

    # Return sitemap
    compiled_buffer

  end
end
