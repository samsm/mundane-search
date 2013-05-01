module MundaneSearch::Filters
  class Typical < Base
    include Optional
    include OptionalWithoutMatchValue
    include MatchValue

    def target
      options[:target] || param_key
    end

  end
end
