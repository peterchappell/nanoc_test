require 'nanoc3/tasks'

require 'aws/s3'
require 'yaml'

=begin
AWS::S3::Base.establish_connection!(
  :access_key_id => ENV['AMAZON_ACCESS_KEY_ID'],
  :secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY']
)
=end
AWS::S3::Base.establish_connection!(
    :access_key_id     => 'AKIAJSXL4CZ4XLBNCCJQ',
    :secret_access_key => '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'
)
include AWS::S3

def file_changed(f)
  if !MrBucket.exists?(f)
    return true
  end
  local_time = open(f).mtime
  live_time = Time.parse(MrBucket.find(f).about[:"last-modified"])
  return local_time > live_time
end

task :upload_assets do
    class MrBucket < AWS::S3::S3Object
        set_current_bucket_to '7mp_test'
    end
    tally = 0
    Dir.chdir("content/_media/") do
      Dir["**/*.{jpg,gif,png}"].each do |f|
        if file_changed(f)
          puts "updating #{f}"
          MrBucket.store("#{f}", open(f), :access => :public_read)
          tally += 1
        end
      end
    end
    puts "#{tally} files uploaded"
end


