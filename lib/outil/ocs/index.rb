module Outil
  module OCS
    class Index

      def initialize params={}
        @path = params[:path]
      end

      def append name, ast
        File.open("#{@path}/#{name}.ast", 'w+') do |file|
            file.write ast.to_yaml
        end
      end

      def read(name)
        File.open("#{@path}/#{name}.ast", 'r') do |file|
            YAML.load(file.read)
        end
      end

      def read_exec(name)
        instance_eval <<-RUBY_EVAL
          #{Unparser.unparse(read(name))}
        RUBY_EVAL
      end

    end
  end
end