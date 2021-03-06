require 'active_support/concern'

module MundaneSearch
  module Buildable
    extend ActiveSupport::Concern

    included do
      class << self
        def builder
          @builder ||= Builder.new
        end
      end
    end


    module ClassMethods
      # Simple delegations to the builder
      [:use, :result_for, :call, :employ].each do |method|
        define_method method do |*args, &block|
          builder.send(method, *args, &block)
        end
      end
    end
  end
end