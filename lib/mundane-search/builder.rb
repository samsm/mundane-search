module MundaneSearch
  class Builder
    def initialize(&block)
      @use = []
      instance_eval(&block) if block_given?
    end

    def use(middleware, *args, &block)
      @use << middleware.new(config, *args, &block)
    end

    def config
      {} # ???, search_mechanism, result_type
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




