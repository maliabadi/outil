require File.expand_path('../lib/outil', __FILE__)

Gem::Specification.new do |gem|
  gem.name             = 'outil'
  gem.homepage           = 'http://www.github.com/maliabadi/outil'
  gem.summary            = 'Stores persistently available utility functions'
  gem.description        = 'Outil is a library for storing and importing reusable code'
  gem.require_path       = 'lib'
  gem.license            = 'MIT'
  gem.authors            = ['Matt Aliabadi']
  gem.email              = ['mattmaliabadi@gmail.com']
  gem.executables        = ['outil-boostrap']
  gem.version            = Outil::VERSION
  gem.platform           = Gem::Platform::RUBY
  gem.files              = Dir.glob("{bin,lib,spec}/**/*")

  gem.add_dependency 'rake'
  gem.add_dependency 'parser', "~>2.0.0.beta5"
  gem.add_dependency 'unparser'
end