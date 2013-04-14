module MundaneSearch
  class ResultModel
    # include ActionViewFormComponents
    # include ColumnsHash

    def self.model_name
      name = 'GenericSearch' unless self.name
      namespace = nil
      ActiveModel::Name.new(self, namespace, name)
    end

    def initialize(result)
      @result = result
    end

    def to_key
      ['result-of-to-key']
    end

    private

    attr_reader :result

    # Attribute methods so that Rails view helpers can access param values.
    def method_missing(m, *args)
      result.stack.all_filters.each do |filter|
        if filter.respond_to?(:param_key) && filter.param_key.to_s == m.to_s
          return params[filter.param_key.to_s]
        end
      end
      super
    end

  end
end