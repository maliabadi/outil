module Outil
  module OCS
    class ObjectParser

      attr :name, :path, :found

      def initialize(path, name)
        @path = path
        @name = name
        @found = false
      end

      def node
        @node ||= Parser::CurrentRuby.parse(
        File.open(@path, 'r') do |f|
          f.read
        end
        )
      end

      def find
        return @found if @found
        set_and_stop = Proc.new do |node|
          return @found = node
        end
        traverse = Proc.new do |node|
          # if we're not at a node, we can move on
          next unless node.is_a?(Parser::AST::Node)
          # unless we're at a method definition
          # we're probably in a begin block, a class, or module
          # in which case traverse the children of the current node
          node.children.each &traverse unless [:defs, :def].include?(node.type)
          # bottom-level node interrogation...
          case node.type
          when :defs
            # class methods
            set_and_stop.call(node) if node.children[1] == name
            next
          when :def
            # instance method
            set_and_stop.call(node) if node.children.first == name
            next
          else
            # other kind of object
            if node.is_a?(Parser::AST::Node)
              # another parent node
              node.children.each &traverse
            else
              # the bottom of a node
              next
            end
          end
        end
        begin
          traverse.call(node)
        rescue
          false
        end
      end

    end
  end
end