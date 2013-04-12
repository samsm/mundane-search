require 'active_model/naming'

module MundaneSearch
  class Result
    include Buildable
    include Enumerable
    include ActionViewFormComponents
    # include ColumnsHash

    attr_reader :stack
    def initialize(collection, params)
      @stack = self.class.builder.result_for(collection,params)
    end

    def call
      stack.collection
    end

    def each(*args, &block)
      return enum_for(__callee__) unless block_given?
      call.each(*args, &block)
    end

    private

    # Attribute methods so that Rails view helpers can access param values.
    def method_missing(m, *args)
      stack.all_filters.each do |filter|
        if filter.respond_to?(:param_key) && filter.param_key.to_s == m.to_s
          return params[filter.param_key.to_s]
        end
      end
      super
    end

    # store...
    #   * builder <- in class
    #   * stack <- in instance
    # generate
    #   * to_model, with pre-built result-specific class
    # delegate to
    #   * collection
    #   * enumeration
  end
end