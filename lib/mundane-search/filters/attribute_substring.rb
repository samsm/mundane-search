module MundaneSearch::Filters
  class AttributeSubstring < Typical
    class ActiveRecord < self
      def filtered_collection
        # collection.where(param_key => params[param_key.to_s])
        collection.where(["#{target} LIKE ?", "%#{params[param_key.to_s]}%"])
      end
    end

    def filtered_collection
      collection.select {|e| e.send(target).index(params[param_key.to_s]) }
    end
  end
end
