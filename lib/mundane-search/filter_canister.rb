module MundaneSearch
  class FilterCanister
    attr_reader :filter, :options
    def initialize(filter, *args)
      @filter, @options = filter, args
    end

    def build(collection, params)
      filter_variant(collection).new(collection, params, *options)
    end

    def filter_variant(collection)
      base = collection.class.to_s.split('::').first.to_sym
      varient = filter.constants.detect {|c| c == base }
      varient ? filter.const_get(varient) : filter
    end

    def param_key
      single_options[:param_key]
    end

    def param_key_type
      single_options[:param_key_type] || param_key_type_from_filter
    end

    private
    def single_options
      options.first || {}
    end

    def param_key_type_from_filter
      filter.param_key_type if filter.respond_to?(:param_key_type)
    end

  end
end
