Gem::Specification.new do |gem|
  gem.name             = 'outil '
  s.homepage           = 'http://www.github.com/malibadi/outil'
  s.summary            = 'Stores persistently available utility functions'
  s.description        = 'Outil is a library for storing and importing reusable code'
  s.require_path       = 'lib'
  s.license            = 'MIT'
  s.authors            = ['Matt Aliabadi']
  s.email              = ['mattmaliabadi@gmail.com']
  s.executables        = ['outil-sync']
  s.version            = MongoMapper::Version
  s.platform           = Gem::Platform::RUBY
  s.files              = Dir.glob("{bin,lib,spec}/**/*")

  s.add_dependency 'activemodel',   ">= 3.0.0"
  s.add_dependency 'activesupport', '>= 3.0'
  s.add_dependency 'plucky',        '~> 0.6.5'
  s.add_dependency 'mongo',         '~> 1.8'
end