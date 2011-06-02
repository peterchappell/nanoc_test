module TocHelper
  def toc (page, indentation=0, sitemap_buffer='')

        # Open list element
        sitemap_buffer << "\t" * indentation + '<li>'

        # Add link
        sitemap_buffer << link_to_unless_current(page[:title], page.reps[0])

        # Add children to sitemap, recursively
        visible_children = page.children.sort_by { |page| page[:order] }
        if visible_children.size > 0

          # Open list
          sitemap_buffer << "\t" * indentation + '<ul>' + "\n"

          # Add children
          visible_children.each do |child|
            toc(child, indentation+1, sitemap_buffer)
          end

          # Close list
          sitemap_buffer << "\t" * indentation + '</ul>' + "\n"

        end

        # Close list element
        sitemap_buffer << '</li>'

    # Return sitemap
    sitemap_buffer

  end
end
