module MundaneSearch::Filters
  class Base
    attr_accessor :options

    def initialize(options = {})
      self.options = options
    end

    def call(collection, params)
      [collection, params]
    end
  end
end
