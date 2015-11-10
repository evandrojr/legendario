# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'legendario/version'

Gem::Specification.new do |spec|
  spec.name          = "legendario"
  spec.version       = Legendario::VERSION
  spec.authors       = ["Evandro Junior"]
  spec.email         = ["evandrojr@gmail.com"]
  spec.summary       = %q{Subtitles downloader on demmand.}
  spec.description   = %q{The script downloads subtitle when a new movie arrives to a specific folder.}
  spec.homepage      = "https://github.com/evandrojr/legendario"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
#  spec.bindir        = "exe"
  spec.bindir        = "lib"


#  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.executables   = ["legendario.rb"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "file-monitor"
  spec.add_development_dependency "osdb"
  spec.add_development_dependency "awesome_print"

end
