module Outil

  class Workspace

    def self.ocs
      @ocs ||= OCS::Config.new
    end

    def self.reset!
      @references = []
      @asts = {}
    end

    def self.references
      @references ||= []
    end

    def self.asts
      @asts ||= {}
    end

    def self.scan path, lineno, name
      references << [path, lineno, name]
      asts[name] = OCS::ObjectParser.new(path, name).find
    end

    def self.sync
      asts.each_pair do |name, tree|
        ocs.index.append name, tree
      end
    end

  end

end