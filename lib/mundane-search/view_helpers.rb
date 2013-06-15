module MundaneSearch
  module ViewHelpers
    def search_url_for(search, change_params = {})
      search_model = search.to_model
      new_model_params = search_model.params.merge(change_params).reject {|k,v| v.nil? }
      new_params = Hash.new
      new_params[search_model.class.model_name.i18n_key] = new_model_params
      polymorphic_url search_model, new_params
    end

    def search_link_for(content, search, change_params = {})
      search_model = search.to_model
      link_to content,
              search_url_for(search, change_params),
              class: will_merge_change_hash?(search_model.params, change_params) ? nil : "unchanged-search"
    end

    # should this be private?
    def will_merge_change_hash?(a,b)
      !(a.merge(b) == a)
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
