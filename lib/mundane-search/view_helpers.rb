module MundaneSearch
  module ViewHelpers
    def search_form_for(record, options = {}, &block)
      # Later!
      # if block_given?
      #   form_for(record, search_form_default_options(record).merge(options), &block)
      # else
      #   # Auto-generate form
      # end
      form_for(record.to_model, search_form_default_options.merge(options), &block)
    end

    def simple_search_form_for(record, options = {}, &block)
      simple_form_for(record.to_model, search_form_default_options.merge(options), &block)
    end

    def search_form_default_options
      {
        method: "GET"
      }
    end
  end
end