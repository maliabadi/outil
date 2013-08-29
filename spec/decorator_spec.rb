require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Outil::Decorators do

  describe Outil::Decorators::Register do

    describe "call" do

      it "should update workspace references" do
        Outil.reset!
        class DummyInterfaceTwo < RubyDecorators::Interface
          use Outil::Decorators::Register
          named :outil

          outil :register
          def baz
            'bar'
          end
        end
        DummyInterfaceTwo.new.baz
        target = [[__FILE__, 18, :baz]]
        Outil::Workspace.references.should eq target
      end
    end

  end

end