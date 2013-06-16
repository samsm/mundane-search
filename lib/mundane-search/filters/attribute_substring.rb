module MundaneSearch::Filters
  class AttributeSubstring < Typical
    class ActiveRecord < self
      def filtered_collection
        collection.where(["#{target} LIKE ?", "%#{match_value}%"])
      end
    end

    def filtered_collection
      collection.select {|e| e.send(target).index(match_value) }
    end
  end
end
