require 'active_model/naming'

module MundaneSearch
  class Result
    include Buildable
    include Enumerable

    attr_reader :stack
    def initialize(collection, params)
      @stack = self.class.builder.result_for(collection,params)
    end

    def to_model
      @result_model ||= ResultModel.new(self)
    end

    def to_a
      stack.collection
    end

    def each(*args, &block)
      return enum_for(__callee__) unless block_given?
      to_a.each(*args, &block)
    end
  end
end
