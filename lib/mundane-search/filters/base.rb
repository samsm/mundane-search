module MundaneSearch::Filters
  class Base
    attr_reader :collection, :params, :options
    def initialize(collection, params = {}, options= {})
      @collection, @params, @options = collection, params, options
    end

    def apply?
      true
    end

    def filtered_collection
      collection
    end

    def filtered_params
      params
    end

    def call
      if apply?
        [filtered_collection, filtered_params]
      else
        [collection, params]
      end
    end
  end
end
