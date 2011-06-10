class KramdownToTex < Nanoc3::Filter
    identifier :kramdown_tex
    type :text

    def run(content, params={})
      require 'kramdown'

      # Get result
      ::Kramdown::Document.new(content, params).to_latex
    end

end
