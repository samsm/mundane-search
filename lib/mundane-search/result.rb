require 'active_model/naming'

module MundaneSearch
  class Result
    include Buildable
    include Enumerable

    class << self
      def options
        @options ||= {}
      end
    end

    attr_reader :stack
    def initialize(collection, params)
      @stack = self.class.builder.result_for(collection,params)
    end

    def to_model
      @result_model ||= self.class.result_model_class(self).new(self)
    end

    def self.result_model_class(result)
      @result_model_class ||= ResultModel.new_model_for(result)
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
