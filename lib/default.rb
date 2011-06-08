# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

require 'lib/helpers/toc'
require 'lib/filters/s3_media'

# Helpers
include Nanoc3::Helpers::LinkTo
include Nanoc3::Helpers::Breadcrumbs
include TocHelper
