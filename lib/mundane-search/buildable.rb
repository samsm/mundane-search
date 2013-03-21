require 'active_support/concern'

module MundaneSearch
  module Buildable
    extend ActiveSupport::Concern

    included do
      class << self
        def builder
          return @builder if @builder
          @builder = Builder.new
          @builder.result_class = self
          @builder
        end
      end
    end


    module ClassMethods
      # Simple delegations to the builder
      [:use, :result_for, :call].each do |method|
        define_method method do |*args, &block|
          builder.send(method, *args, &block)
        end
      end
    end
  end
end