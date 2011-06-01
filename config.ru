gem 'rack-rewrite', '~> 1.0.0'
require 'rack/rewrite'
use Rack::Rewrite do
  r301 %r{^([^\.]*[^\/])$}, '$1/'
  r301 %r{^(.*\/)$}, '$1index.html'
end

use Rack::Static, :urls => ["/"], :root => Dir.pwd + '/output'

# Empty app, should never be reached:
class Homepage
  def call(env)
    [200, {"Content-Type" => "text/html"}, ["There's a problem with my website. Ooops./"] ]
  end
end
run Homepage.new

