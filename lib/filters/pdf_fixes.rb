# This one needs to be called AFTER conversion to tex
class PdfFix_figure_floats < Nanoc3::Filter

    identifier :pdfFix_figure_floats
    type :text
    def run(content, params={})

      # set the positioning defaults for figures
      content.gsub(/(\\begin\{figure\})/) do
        $1 + '[htb]'
      end

      # kludge to wrap text in tables
      content.gsub(/(\{longtable\}\{.*?)(\|l\|)(.*?\})/) do
        $1 + '|p{0.5\textwidth}|' + $3
      end

    end

end
