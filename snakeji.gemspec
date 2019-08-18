
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "snakeji/version"

Gem::Specification.new do |spec|
  spec.name          = "snakeji"
  spec.version       = Snakeji::VERSION
  spec.authors       = ["returnv01d"]
  spec.email         = ["b.winiarski97@gmail.com"]

  spec.summary       = %q{multiplayer snake game}
  spec.homepage      = "https://github.com/returnv01d/snakeji"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "ruby2d", "= 0.9.0"
end
