module MundaneSearch::Filters
  class Typical < Base
    def self.param_key_type
      :string # common default
    end

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
      options[:match_value] || params[param_key]
    end

    # This is a duplicate of the class method?
    def param_key_type
      options[:type] || self.class.param_key_type
    end
  end
end
