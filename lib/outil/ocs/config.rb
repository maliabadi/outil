module Outil
  module OCS
    class Config

      def self.home_path
        @home_path ||= File.expand_path(
          File.expand_path(ENV['HOME'] || '~'))
      end

      attr :params

      def initialize(params={})
        @params = params
        infer_path unless @params[:path]
      end

      def options
        @options ||= (
          unless File.exists?(infer_path)
            raise StandardError "Could not locate your Outil Config File"
          end
          indifference = Proc.new do |hash, x|
            hash[x.first] = x.last
            hash[x.first.to_sym] = x.last
            hash
          end
          YAML.load_file(infer_path)
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

      def infer_path
        @params[:path] = "#{self.class.home_path}/#{Outil::OCS::CONFIG_PATH}"
      end

    end
  end
end

