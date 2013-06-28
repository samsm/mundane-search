require 'active_model/validations'
require 'active_model/naming'
require 'active_model/translation'
require 'attribute_column'

module MundaneSearch
  class ResultModel
    include AttributeColumn
    include ActiveModel::Validations

    def self.model_class_for(result_class)
      builder = result_class.builder
      Class.new(ResultModel) do |model_class|
        model_class.model_name = result_class.options[:name] || result_class.name
        builder.filter_canisters.each do |fc|
          fc.option_keys_with_types.each do |key, type|
            attribute_column(key, type)
            define_method(key) do
              send(:result).stack.params[key.to_s]
            end
          end
        end
      end
    end

    # Added this for the benefit of search_url_for
    # If it stays, it should replace stack.params in the method above.
    def params
      send(:result).stack.params
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
