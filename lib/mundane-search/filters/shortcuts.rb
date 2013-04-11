require 'active_support/inflector'

module MundaneSearch
  module Filters
    module Shortcuts
      def employ(shortcut, options = {}, &block)
        filter_name, default_options = filter_for(shortcut)
        filter = "#{filter_name}".safe_constantize
        raise "No filter found for #{shortcut}" unless filter
        [options].flatten.each do |opts|
          use filter, default_options.merge(opts), &block
        end
      end

      private

      # Use symbols to avoid loading all shortcutted filters.
      def filter_for(shortcut)
        {
          attribute_filter: [:"MundaneSearch::Filters::AttributeMatch", {}],
          filter_greater_than: operator_filter(:>),
          filter_less_than:    operator_filter(:<),
          filter_greater_than_or_equal_to: operator_filter(:>=),
          filter_less_than_or_equal_to:    operator_filter(:<=),
        }[shortcut]
      end

      def operator_filter(operator)
        [:"MundaneSearch::Filters::Operator", { operator: operator }]
      end
    end
  end
end
