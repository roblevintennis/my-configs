$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'google'
require 'webrat'

require 'spec/expectations'

Webrat.configure do |config|
  config.mode = :mechanize
end

World(Webrat::Methods)
World(Webrat::Matchers)

