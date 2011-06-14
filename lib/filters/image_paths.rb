class ImagePathsFilter < Nanoc3::Filter
  identifier :rewrite_image_paths
  type :text

  def run(content, params={})
    case params[:type]
    when :html
      content.gsub(/(<[^>]+\s+(src|href))=(['"]?)(\/_media\/)(.*?)\3([ >])/) do
        $1 + '=' + $3 + 'https://s3.amazonaws.com/' + params[:bucket] + '/' + $5 + $3 + $6
      end
    when :tex
      content.gsub(/.*\/_media\/(.*)\}/) do
        # this would have been good - the idea is that we download from S3 to build the pdf - http://tex.stackexchange.com/questions/5433/can-i-use-an-image-located-on-the-web-in-a-latex-document
        # doesn't work though
        # '\write18{wget ' + 'https://s3.amazonaws.com/' + params[:bucket] + '/' + $1 + '}' + '
        # ' + '\includegraphics[width=40mm]{' + $1 + '}'
        '\includegraphics[width=100mm]{_media/' + $1 + '}'
      end
    else
      raise RuntimeError.new(
        "The S3Media Filter only works for html at the moment"
      )
    end
  end

end
