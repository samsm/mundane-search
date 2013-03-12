module MundaneSearch::Filters::Helpers
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def optional_unless_required
      include Optional
    end

    def optional_without_match_value
      include OptionalWithoutMatchValue
    end

    def has_a_match_value
      include MatchValue
    end

  end


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
  end
end