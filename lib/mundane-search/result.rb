require 'active_model/naming'

module MundaneSearch
  class Result
    include Enumerable
    include ColumnsHash
    include ActionViewFormComponents

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
      run_filter!
      @collection
    end

    # necessary?
    def params
      run_filter!
      @params
    end

    def add_filter(filter_canister)
      result_class.new(self,filter_canister)
    end

    def each(*args, &block)
      return enum_for(__callee__) unless block_given?
      collection.each(*args, &block)
    end

    def filter
      @filter ||= filter_canister.build(previous_result.collection, previous_result.params)
    end

    private

    attr_reader :previous_result, :filter_canister

    def run_filter!
      @collection || (@collection, @params = filter.call)
    end

    def result_class
      @result_class || Result
    end

    # Attribute methods so that Rails view helpers can access param values.
    def method_missing(m, *args)
      all_filters.each do |filter|
        if filter.respond_to?(:param_key) && filter.param_key.to_s == m.to_s
          return params[filter.param_key.to_s]
        end
      end
      super
    end
  end
end