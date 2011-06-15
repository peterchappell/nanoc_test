# This one needs to be called AFTER conversion to tex
class PdfFix_figure_floats < Nanoc3::Filter

    identifier :pdfFix_figure_floats
    type :text
    def run(content, params={})
      content.gsub(/(\\begin\{figure\})/) do
        $1 + '[htb]'
      end
    end

end
