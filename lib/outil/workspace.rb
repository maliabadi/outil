module Outil

  class Workspace

    def self.objects
      @objects ||= []
    end

    def self.scan path, lineno
      objects << [path, lineno]
    end
  end

end