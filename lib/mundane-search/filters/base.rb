module MundaneSearch::Filters
  class Base
    attr_reader :collection, :params, :options
    def initialize(collection, params, options= {})
      @collection, @params, @options = collection, params, options
    end

    def filtered_collection
      collection
    end

    def filtered_params
      params
    end

    def call
      [filtered_collection, filtered_params]
    end
  end
end
