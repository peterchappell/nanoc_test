require 'nanoc3/tasks'
require 'aws/s3'
require 'yaml'

# SETUP FOR AWS S3 UPLOAD
AWS::S3::Base.establish_connection!(
    :access_key_id     => 'AKIAJSXL4CZ4XLBNCCJQ',
    :secret_access_key => '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'
)
include AWS::S3

# used by S3 uploader to only upload changed files
def file_changed(f)
  if !MrBucket.exists?(f)
    return true
  end
  local_time = open(f).mtime
  live_time = Time.parse(MrBucket.find(f).about[:"last-modified"])
  return local_time > live_time
end



# ######
# TASK TO COMPILE THE SITE
# ######
desc "Compile the site using nanoc"
task :compile_only do
    system 'nanoc compile'
end

# ######
# TASK TO COMPILE THE SITE AND MANAGE ASSETS
# ######
desc "Compile the site using nanoc and put any new assets up on Amazon"
task :compile => [:compile_only, :upload_assets] do
    puts "compiled the site and uploaded the assets"
end

# ######
# TASK TO UPLOAD ASSETS TO S3
# ######
desc "Upload just the assets (_media) to Amazon S3)"
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

# ######
# TASK TO UPLOAD ENTIRE SITE TO S3
# ######
desc "Upload entire static site to Amazon S3"
task :upload_site_s3 do
    class MrBucket < AWS::S3::S3Object
        set_current_bucket_to '7mpweb'
    end
    tally = 0
    Dir.chdir("output/") do
      Dir["**/*.*"].each do |f|
        if File.directory?(f)
          puts f
        elsif file_changed(f)
          puts "updating #{f}"
          MrBucket.store("#{f}", open(f), :access => :public_read)
          tally += 1
        end
      end
    end
    puts "#{tally} files uploaded"
end


