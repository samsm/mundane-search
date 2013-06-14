module MundaneSearch::Filters
  class Order < Typical
    class ActiveRecord < self
      def filtered_collection
        collection.order("#{match_value} #{active_record_direction}")
      end

      def active_record_direction
        direction || "ASC"
      end
    end

    def filtered_collection
      collection.sort_by(&:"#{match_value}")
      backwards? ? collection.reverse : collection
    end

    protected
    def backwards?
      descending_terms.include?(direction)
    end

    def direction
      params["direction"] || options[:direction]
    end

    def ascending_terms
      %w(asc ascending <)
    end

    def descending_terms
      %w(desc descending >)
    end
  end
end
