module MundaneSearch
  class Stack
    def all_filters
      return @all_filters if @all_filters
      @all_filters = all_results.collect(&:filter)
    end

    def all_results
      [self] + previous_result.all_results
    end

    def initialize(previous_result, filter_canister)
      @previous_result, @filter_canister = previous_result, filter_canister
    end

    def collection
      filter.call.first
    end

    # necessary?
    def params
      filter.call.last
    end

    def add_filter(filter_canister)
      Stack.new(self,filter_canister)
    end

    def filter
      @filter ||= filter_canister.build(previous_result.collection, previous_result.params)
    end

    private

    attr_reader :previous_result, :filter_canister

  end
end