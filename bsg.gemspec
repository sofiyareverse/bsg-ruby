# bsg.gemspec
Gem::Specification.new do |spec|
  spec.name          = "bsg"
  spec.version       = "0.1.0"
  spec.authors       = ["BSG"]
  spec.email         = ["support@bsg.world"]

  spec.summary       = "BSG Ruby Client"
  spec.description   = "A Ruby wrapper for BSG SMS API"
  spec.homepage      = "https://github.com/yourusername/bsg-ruby"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*.rb"]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.5"

  spec.add_runtime_dependency "net-http", ">= 0"
  spec.add_runtime_dependency "rest-client", "~> 2.1"
end

