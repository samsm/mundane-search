module MundaneSearch::Filters
  class MultiOrder < Typical

    class ActiveRecord < self
      def filtered_collection
        collection.order(order_string)
      end

      private
      def order_string
        # puts
        # puts "*** This requires escaping! ***"

        statement = ordering_pairs.to_a.collect {|p| p.join(" ") }.join(", ")
        escape_for_order_sql statement
      end

      def escape_for_order_sql(unescaped)
        # This is crude, but agressive. Should workd for order statements.
        # Escapes everything but [a-zA-Z0-9_,.] and whitespace
        unescaped[/[.,\w\s]+/]
      end
    end

    def filtered_collection
      collection.reverse.sort do |a,b|
        compare = ordering_pairs.inject([[],[]]) do |sum, pair|
          attribute, direction = pair
          attribute = :"#{attribute}"
          if ascending_terms.include?(direction)
            sum.first << a.send(attribute)
            sum.last  << b.send(attribute)
          else
            sum.first << b.send(attribute)
            sum.last  << a.send(attribute)
          end
          sum
        end
        compare.first <=> compare.last
      end
    end

    private

    def ordering_pairs
      if match_value.kind_of?(String)
        match_value.split(";").inject({}) do |hsh, pair|
          key, val = pair.split(":")
          hsh[key] = val || "asc"
          hsh
        end
      else
        Hash[keys_to_sort_on.zip(corresponding_directions_to_sort)]
      end
    end

    def directions_key
      options[:directions_key] || "directions"
    end
    def keys_to_sort_on
      match_value
    end

    def corresponding_directions_to_sort
      params[directions_key]
    end

    # These are duplicated in MultiOrder
    def ascending_terms
      %w(asc ascending <)
    end

    def descending_terms
      %w(desc descending >)
    end

  end
end
