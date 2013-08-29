module Outil
  module OCS
    class Index

      attr :path

      def initialize params={}
        @path = params[:path]
      end

      def index_path
        @index_path ||= "#{@path}/index"
      end

      def append name, ast
        write_serialize name, ast
        update_index name
      end

      def write_serialize name, ast
        File.open("#{@path}/#{name}.ast", 'w+') do |file|
            file.write ast.to_yaml
        end
      end

      def indexed_names
        File.open(index_path, 'r') do |f|
          f.read.split(/\n/)
        end.map(&:strip)
      end

      def update_index name
        return if indexed_names.include?(name.to_s)
        File.open(index_path, 'a') do |file|
          file.write name.to_s << "\n"
        end
      end

      def read(name)
        File.open("#{@path}/#{name}.ast", 'r') do |file|
            YAML.load(file.read)
        end
      end

      def all
        indexed_names.map do |name|
          read name
        end
      end

      def read_exec(name)
        instance_eval <<-RUBY_EVAL
          #{Unparser.unparse(read(name))}
        RUBY_EVAL
      end

      def hard_reset!
        Dir["#{@path}/*.ast"].each do |path| 
          File.delete path
        end
        File.open(index_path, 'w+') do |file|
          file.write String.new
        end
      end

    end
  end
end