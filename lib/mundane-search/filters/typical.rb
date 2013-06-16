module MundaneSearch::Filters
  class Typical < Base
    def self.key_types
      { key: key_type }
    end

    def self.key_type
      # common default
      :string
    end

    def target
      options[:target] || key
    end

    def optional?
      options[:required]
    end

    def apply?
      match_value || optional?
    end

    def key
      options.fetch(:key)
    end

    def match_value
      options[:match_value] || params[key]
    end

    def key_type
      options[:type] || self.class.key_type
    end
  end
end
