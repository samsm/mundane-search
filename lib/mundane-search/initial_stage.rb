module MundaneSearch
  class InitialStage < Stage
    def initialize(collection,params, result_class=nil)
      @collection, @params, @result_class = collection, params, result_class
    end

    def all_results
      []
    end

  end
end