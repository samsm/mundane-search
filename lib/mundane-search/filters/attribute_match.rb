module MundaneSearch::Filters
  class AttributeMatch < Typical
    class ActiveRecord < self
      def filtered_collection
        collection.where(param_key => params[param_key.to_s])
      end
    end

    def filtered_collection
      collection.select {|e| e.send(param_key) == params[param_key.to_s] }
    end
  end
end
