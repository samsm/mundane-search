module MundaneSearch
  class Builder

    include MundaneSearch::Filters::Shortcuts

    def initialize(&block)
      @use = []
      instance_eval(&block) if block_given?
    end

    def use(filter, *args, &block)
      @use << build_filter_canister.call(filter, *args, &block)
    end

    def call(collection, params = {})
      result = result_for(collection, params)
      result.collection
    end

    def result_for(collection, params = {})
      initial_result = InitialStack.new(collection, params)
      filter_canisters.inject(initial_result) do |result, canister|
        result.add_filter(canister)
      end
    end

    private

    def filter_canisters
      @use
    end

    def build_filter_canister
      FilterCanister.public_method(:new)
    end
  end
end