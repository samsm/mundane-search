module MundaneSearch
  class Builder
    include MundaneSearch::Filters::Shortcuts

    def initialize(&block)
      @filter_canisters = []
      instance_eval(&block) if block_given?
    end

    def use(filter, *args, &block)
      @filter_canisters << build_filter_canister.call(filter, *args, &block)
    end

    def call(collection, params = {})
      result = result_for(collection, params)
      result.collection
    end

    def result_for(collection, params = {})
      initial_stack = InitialStack.new(collection, params)
      filter_canisters.inject(initial_stack) do |stack, canister|
        stack.add(canister)
      end
    end

    private

    attr_reader :filter_canisters

    def build_filter_canister
      FilterCanister.public_method(:new)
    end
  end
end