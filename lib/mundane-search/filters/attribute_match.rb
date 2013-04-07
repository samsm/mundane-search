module MundaneSearch::Filters
  class AttributeMatch < Typical
    def filtered_collection
      # This switch ... somewhere else?
      case collection.to_s
      when "ActiveRecord::Relation"
        collection.where(param_key => params[param_key.to_s])
      when :sunspot?
        # nothing yet
      else
        collection.select {|e| e.send(param_key) == params[param_key.to_s] }
      end
    end
  end
end