module MundaneSearch::Filters
  class ExactMatch < Typical
    def filtered_collection
      if apply?
        collection.select {|e| e == match_value }
      else
        collection
      end
    end
  end
end
