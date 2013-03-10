module MundaneSearch
  class BasicFilter
    attr_accessor :options

    def initialize(options = {})
      self.options = options
    end

    def call(collection, params)
      [collection, params]
    end
  end

  class ExactMatch < BasicFilter
    def params_key
      options[:value]
    end

    def call(collection, params)
      collection.select {|e| e == params[params_key] }
    end
  end
end