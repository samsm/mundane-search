require 'active_model/validations'
require 'active_model/naming'
require 'active_model/translation'

module MundaneSearch
  class ResultModel
    include ColumnsHash
    include ActiveModel::Validations

    def self.new_model_for(result)
      result_class = result.class
      Class.new(ResultModel) do |rm|
        rm.model_name = result_class.options[:name] || result_class.name
        result.stack.all_filters.each do |filter|
          if filter.respond_to?(:param_key) && filter.param_key
            # Need real type here:
            attribute_column(filter.param_key, :string)
            define_method filter.param_key do
              send(:result).stack.params[filter.param_key.to_s]
            end
          end
        end
      end
    end

    def self.model_name
      name = 'GenericSearch' unless self.name
      namespace = nil
      ForcedSingularRouteKeyName.new(self, namespace, (@model_name || name))
    end

    # As string, for when ActionView turns a model name into a url.
    def self.model_name=(name)
      @model_name = name
    end

    def initialize(result)
      @result = result
    end

    def to_key
      ['result-of-to-key']
    end

    def to_model
      self
    end

    def persisted?
      false
    end

    private

    attr_reader :result

  end

  class ForcedSingularRouteKeyName < ActiveModel::Name
    def initialize(klass, namespace = nil, name = nil)
      super(klass, namespace, name)
      @route_key = (namespace ? ActiveSupport::Inflector.singularize(@param_key) : @singular.dup)
    end
  end

end
