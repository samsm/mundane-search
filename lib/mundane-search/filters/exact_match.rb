module MundaneSearch::Filters
  class ExactMatch < Base
    attr_reader :collection, :params, :options
    def initialize(collection, params, options)
      @collection, @params, @options = collection, params, options
    end

    def param_key
      options.fetch(:param_key)
    end

    def optional?
      options[:mandatory]
    end

    def apply?
      match_value || optional?
    end

    def match_value
      params[param_key]
    end

    def filtered_collection
      if apply?
        collection.select {|e| e == match_value }
      else
        collection
      end
    end

    def call
      [filtered_collection, params]
    end

  end
end
