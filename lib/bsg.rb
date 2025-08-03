require_relative "bsg/client"
require_relative "bsg/response" if File.exist?(File.expand_path("bsg/response.rb", __dir__))

module BSG
end
