module MundaneSearch
  class Result
    include Enumerable
    attr_reader :collection, :params, :previous_result
    def initialize(previous_result, filter)
      @previous_result = previous_result
      @collection, @params = filter.call(previous_result.collection, previous_result.params)
    end

    def add_filter(filter)
      Result.new(self,filter)
    end

    def each(*args, &block)
      return enum_for(__callee__) unless block_given?
      collection.each(*args, &block)
    end
  end
end