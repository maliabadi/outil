module Outil

  module OCS

    # Object Control System



    class << self

      def config(params={})
        @config ||= Config.new(params)
      end

      def bootstrap opt={}
        opt[:config] ||= "#{Dir.home}/#{OBJECT_PATH}"
        opt[:index] ||= @config.infer_path
        Dir.mkdir(opt[:index])
        File.open(opt.delete(:config), 'w+') do |f|
          f.write opt.to_yml
        end
      end

    end
  end

end
