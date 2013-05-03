require 'active_support/inflector'

module MundaneSearch
  class Builder
    include MundaneSearch::Filters::Shortcuts

    def initialize(&block)
      @filter_canisters = []
      instance_eval(&block) if block_given?
    end

    def use(filter, *args, &block)
      filter = convert_filter(filter)
      @filter_canisters << build_filter_canister.call(filter, *args, &block)
    end

    def call(collection, params = {})
      result = result_for(collection, params)
      result.collection
    end

    def result_for(collection, params = {})
      params ||= {} # tollerate nil
      initial_stack = InitialStack.new(collection, params)
      filter_canisters.inject(initial_stack) do |stack, canister|
        stack.add(canister)
      end
    end

    attr_reader :filter_canisters

    private

    def build_filter_canister
      FilterCanister.public_method(:new)
    end

    def convert_filter(filter)
      case filter
      when Class
        filter
      when String, Symbol
        camelized = "#{filter}".camelize
        [Object, MundaneSearch::Filters].each do |filter_base|
          if filter_base.const_defined?(camelized)
            break(filter_base.const_get(camelized))
          end
        end
      else
        # Warning: May not be a valid filter
        filter
      end
    end
  end
end