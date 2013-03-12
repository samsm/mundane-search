module MundaneSearch::Filters
  class Typical < Base
    has_a_match_value
    optional_without_match_value
  end
end