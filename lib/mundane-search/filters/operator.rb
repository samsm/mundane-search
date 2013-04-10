module MundaneSearch::Filters
  class Operator < Typical
    class ActiveRecord < self
      def filtered_collection
        collection.where(["#{target} #{operator} ?", params[param_key.to_s]])
      end
    end

    def filtered_collection
      collection.select {|e| e.send(target).send(operator, params[param_key.to_s]) }
    end

    def operator
      options[:operator]
    end

    def target
      options[:target] || param_key
    end
  end
end
