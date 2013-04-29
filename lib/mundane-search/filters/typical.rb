module MundaneSearch::Filters
  class Typical < Base
    has_a_match_value
    optional_without_match_value

    def target
      options[:target] || param_key
    end

  end
end
