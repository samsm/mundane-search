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

    def option_keys_with_types
      ParamKeyTypes.new(single_options, filter).pairs
    end

    private
    def single_options
      options.first || {}
    end
  end
end


