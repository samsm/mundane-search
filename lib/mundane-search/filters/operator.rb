module MundaneSearch::Filters
  class Operator < Typical
    class ActiveRecord < self
      def filtered_collection
        collection.where(["#{target} #{operator} ?", match_value])
      end
    end

    def filtered_collection
      collection.select {|e| e.send(target).send(operator, match_value) }
    end

    def operator
      options[:operator]
    end

  end
end
