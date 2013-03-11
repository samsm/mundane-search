module MundaneSearch::Filters
  class ExactMatch < Base
    def params_key
      options[:value]
    end

    def call(collection, params)
      collection.select {|e| e == params[params_key] }
    end
  end
end
