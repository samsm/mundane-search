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
      option_keys.collect do |key|
        [single_options[key], param_key_types[key]]
      end
    end

    private
    def single_options
      options.first || {}
    end

    def option_keys
      single_options.keys.select {|k| k.to_s =~ /_key\Z/ }
    end

    def param_key_types
      param_key_types_from_filter.merge(param_key_types_from_options)
    end

    def param_key_types_from_filter
      filter.respond_to?(:param_key_types) ? filter.param_key_types : {}
    end

    def param_key_types_from_options
      single_options.keys.select {|k| k.to_s =~ /_type\Z/ }.inject({}) do |hsh, key|
        typeless_key = key.to_s.sub(/_type\Z/, '')
        hsh[:"#{typeless_key}"] = single_options[key]
        hsh
      end
    end

  end
end
