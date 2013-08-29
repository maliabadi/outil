module Outil
  module OCS
    class Config

      INDEX_PATH = '.outil'
      CONFIG_PATH = '.outil.rc'

      def self.home_path
        @home_path ||= File.expand_path(
          File.expand_path(ENV['HOME'] || '~'))
      end

      attr :params

      def initialize(params={})
        @params = params
        infer = Proc.new do |key, const|
          @params[key] = "#{self.class.home_path}/#{const}"
        end
        infer.call(:index, INDEX_PATH)
        infer.call(:path, CONFIG_PATH)
      end

      def options
        @options ||= (
          unless File.exists?(@params[:path])
            raise StandardError "Could not locate your Outil Config File"
          end
          indifference = Proc.new do |hash, x|
            hash[x.first] = x.last
            hash[x.first.to_sym] = x.last
            hash
          end
          YAML.load_file(@params[:path])
            .inject(Hash.new, &indifference)
          )
      end

      def index
        @index ||= (
          unless options[:index]
            raise StandardError "Could not locate your Outil Index Path"
          end
          Index.new(:path => options[:index])
        )
      end

    end
  end
end

