module MundaneSearch
  class Result
    attr_reader :collection
    def initialize(previous_result, filter)
      @previous_result = previous_result
      @collection, @params = filter[previous_result.collection, previous_result.params]
    end

    def add_filter(filter)
      self.class.new(self,filter)
    end

    def each(*args, &block)
      # ???
      return enum_for(__callee__) unless block_given?
      collection.each(*args, &block)
    end
  end

  class InitialResult < Result
    attr_reader :collection, :params
    def initialize(collection,params)
      @collection, @params = collection, params
    end

    def search_mechanism
      options[:search_mechanism] or default
    end
  end
end