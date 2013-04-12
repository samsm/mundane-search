module MundaneSearch
  class InitialStack < Stack
    attr_reader :collection, :params
    def initialize(collection,params)
      @collection, @params, @result_class = collection, params
    end

    def all_results
      []
    end

  end
end