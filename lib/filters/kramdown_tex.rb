class KramdownToTex < Nanoc3::Filter

    identifier :kramdown_tex
    type :text
    def run(content, params={})
      require 'kramdown'
      # Get result
      ::Kramdown::Document.new(content, params).to_latex
    end

end

class KramdownFigureFloats < Nanoc3::Filter

    identifier :kramdown_fix_figure_floats
    type :text
    def run(content, params={})
      content.gsub(/(\\begin\{figure\})/) do
        $1 + '[htb]'
      end
    end

end

