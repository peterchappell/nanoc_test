# This is the Compass configuration file. The configuration file for nanoc is
# named Òconfig.yamlÓ.

project_path = '.'
http_path = '/'
sass_dir = 'content/scss'
css_dir = 'output/css'

sass_options = {
  :syntax => :scss
}

# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed
output_style = :compact

# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
line_comments = false


# If you prefer the indented syntax, you might want to regenerate this
# project again passing --syntax sass, or you can uncomment this:
# preferred_syntax = :sass
# and then run:
# sass-convert -R --from scss --to sass sass scss && rm -rf sass && mv scss sass
