module MundaneSearch::Filters::Helpers
  module Optional
    def optional?
      options[:required]
    end
  end

  module OptionalWithoutMatchValue
    include Optional
    def apply?
      match_value || optional?
    end
  end

  module MatchValue
    def param_key
      options.fetch(:param_key)
    end

    def match_value
      params[param_key]
    end

    def param_key_type
      options[:type] || :string
    end
  end
end
