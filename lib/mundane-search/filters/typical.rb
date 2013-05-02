module MundaneSearch::Filters
  class Typical < Base

    def target
      options[:target] || param_key
    end

    def optional?
      options[:required]
    end

    def apply?
      match_value || optional?
    end

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
