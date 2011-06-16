require 'nanoc3/tasks'
require 'aws/s3'
require 'yaml'
#require 'net/http'

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
task :compile => [:compile_only, :upload_assets, :download_assets, :create_pdf] do
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
# TASK TO DOWNLOAD ASSETS FROM S3
# ######
desc "Download the assets (_media) from Amazon S3 to local (for PDF creation)"
task :download_assets, :pdf_or_content do |t,args|
    download_to = args[:pdf_or_content] || 'pdf'
    if download_to == 'content'
        download_path = 'content/_media/'
    else
        download_path = 'output/pdf/_media/'
    end
    puts 'Downloading media from Amazon S3 to ' + download_path
    @files = AWS::S3::Bucket.find('7mp_test').objects
    @files.each do |file|
        puts '------'
        puts file.key
        download_file = download_path + file.key
        if FileTest.exists?(download_file) && (Time.parse(file.about[:'last-modified']) < open(download_file).mtime)
            puts 'server modified: ' + file.about[:'last-modified']
            puts 'local modified: ' + open(download_file).mtime.asctime
            puts 'local newer: ' + (open(download_file).mtime > Time.parse(file.about[:'last-modified'])).to_s
            puts 'file already exists locally and is more recent than S3'
        else
            new_file = File.new(download_path+file.key,'w')
            new_file.puts file.value
            new_file.close
            puts 'file downloaded'
        end
    end
    puts 'Finished downloading media from Amazon S3'
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

# ######
# TASK TO GENERATE PDFs
# ######
desc "Create PDF files"
task :create_pdf do
    # do it once
    sh 'pdflatex -output-directory=output/pdf output/pdf/7-million-pockets.tex' do | ok, res |
        if ! ok
            puts "pattern not found (status = #{res.exitstatus})"
        end
    end
    # do it twice to make sure the TOC is compiled (apparently it's a LaTeX thing)
    sh 'pdflatex -output-directory=output/pdf output/pdf/7-million-pockets.tex' do | ok, res |
        if ! ok
            puts "pattern not found (status = #{res.exitstatus})"
        end
    end
    puts 'created the PDF (or tried to at least)'
end



