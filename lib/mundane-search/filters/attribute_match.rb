module MundaneSearch::Filters
  class AttributeMatch < Typical
    class ActiveRecord < self
      def filtered_collection
        collection.where(target => match_value)
      end
    end

    def filtered_collection
      collection.select {|e| e.send(target) == match_value }
    end
  end
end
