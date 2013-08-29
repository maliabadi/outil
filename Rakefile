require 'rubygems'
require 'bundler/setup'
require 'rake'
require File.expand_path('../lib/outil/outil', __FILE__)

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |spec|
    spec.pattern = 'spec/**/*_spec.rb'
    spec.rspec_opts = ['--color']
  end
  task :default => :spec  
rescue LoadError
  nil
end