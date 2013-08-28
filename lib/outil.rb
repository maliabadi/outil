require 'bundler/setup'
require 'ruby_decorators'
require 'parser/current'
require 'unparser'
require 'yaml'

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'outil/decorators'
require 'outil/workspace'
require 'outil/ocs'
require 'outil/ocs/index'
require 'outil/ocs/config'
require 'outil/ocs/parser'

module Outil
    
end
