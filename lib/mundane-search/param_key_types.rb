module MundaneSearch
  class ParamKeyTypes
    attr_reader :options, :filter
    def initialize(options, filter)
      @options, @filter = options, filter
    end

    def pairs
      kt = key_types
      option_keys.inject({}) do |hsh, key|
        hsh[options[key]] = kt["#{key}"] || kt[:"#{key}"]
        hsh
      end
    end

    private

    def key_types
      key_types_from_filter.merge(key_types_from_options)
    end

    def key_types_from_options
      option_types.inject({}) do |types, k|
        param_key = "#{k}".sub(/(_key)?_type\Z/,'_key')
        param_key = "key" if param_key.to_s == "type"
        types[param_key] = options[k]
        types
      end
    end

    def key_types_from_filter
      filter.respond_to?(:key_types) ? filter.key_types : {}
    end

    def option_keys
      options.keys.select {|k| (k.to_s =~ /_key\Z/) || k.to_s == "key" }
    end

    def option_types
      options.keys.select {|k| (k.to_s =~ /_type\Z/) || k.to_s == "type" }
    end
  end
end
