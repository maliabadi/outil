require File.expand_path('../../lib/outil', __FILE__)
require 'rspec'
require 'rspec/expectations'

class DummyInterface < RubyDecorators::Interface
    use Outil::Decorators::Register
    named :outil

    outil :register
    def hello
        'hello'
    end
end
