require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class DummyInterface < RubyDecorators::Interface
    use Outil::Decorators::Register
    named :outil

    outil :register
    def hello
        'hello'
    end
end

describe Outil::Decorators::Register do

    describe "adds file and line number to objects" do
        DummyInterface.new.hello
        puts Outil::Workspace.objects
    end

end