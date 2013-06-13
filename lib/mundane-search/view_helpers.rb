module MundaneSearch
  module ViewHelpers
    def search_url_for(search, change_params = {})
      search_model = search.to_model
      new_parms = search_model.params.merge(change_params).reject {|k,v| v.nil? }
      polymorphic_url search_model, new_parms
    end

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
      # TODO: warn if simple_form not available?
      simple_form_for(record.to_model, search_form_default_options.merge(options), &block)
    end

    def search_form_default_options
      {
        method: "GET"
      }
    end
  end
end
