module MundaneSearch
  module ViewHelpers
    def search_form_for(record, options = {}, &block)
      # Later!
      # if block_given?
      #   form_for(record, search_form_default_options(record).merge(options), &block)
      # else
      #   # Auto-generate form
      # end
      form_for(record, search_form_default_options(record).merge(options), &block)
    end

    def search_form_default_options(record)
      {
        method: "GET"
      }
    end
  end
end