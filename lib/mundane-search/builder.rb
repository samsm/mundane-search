module MundaneSearch
  class Builder
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

    def call(collection, params)
      result = execute(collection, params)
      [result.collection, result.params]
    end

    def execute(collection, params)
      initial_result = InitialResult.new(collection, params)
      filters.inject(initial_result) do |result, filter|
        result.add_filter(filter)
      end
    end
  end
end




