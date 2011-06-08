class S3MediaFilter < Nanoc3::Filter
  identifier :s3_media
  type :text

  def run(content, params={})
    case params[:type]
    when :html
      content.gsub(/(<[^>]+\s+(src|href))=(['"]?)(\/_media\/)(.*?)\3([ >])/) do
        $1 + '=' + $3 + 'https://s3.amazonaws.com/' + params[:bucket] + '/' + $5 + $3 + $6
      end
    else
      raise RuntimeError.new(
        "The S3Media Filter only works for html at the moment"
      )
    end
  end

end
