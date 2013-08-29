module Outil

  module OCS

    # Object Control System

    class << self

      def config(params={})
        @config ||= Config.new(params)
      end

      def bootstrap options={}
        options.merge! Config.new().params
        Dir.mkdir(options[:index]) unless Dir.exists?(options[:index])
        File.open(options.delete(:path), 'w+') do |f|
          f.write options.to_yaml
        end
      end

    end
  end

end
