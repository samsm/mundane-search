require_relative './filters'

module MundaneSearch
  class Builder
    include MundaneSearch::Filters

    def initialize(&block)
      @use = []

      instance_eval(&block) if block_given?
    end

    def use(filter, *args, &block)
      @use << filter_canister.new(filter, *args, &block)
    end

    def filter_canister
      FilterCanister
    end

    def filters
      @use
    end

    def call(collection, params = {})
      result = result_for(collection, params)
      result.collection
    end

    def result_for(collection, params = {})
      initial_result = InitialResult.new(collection, params)
      filters.inject(initial_result) do |result, filter|
        result.add_filter(filter)
      end
    end
  end
end




