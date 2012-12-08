require 'active_support/hash_with_indifferent_access'
module MundaneSearch
  class InvalidOption < StandardError ; end
  class Filter
    # {
    #   name: 'Awesomefilter',
    #   target: 'created_at',
    #   search_type: 'time', # optional
    #   search_method: ->(scope, term) { scope.where(["foo = ? ", term]) }
    #   search_procs: {active_record: ->(term) {...} }
    #   filter_mechanism: 'ActiveRecord', # Sunspot, etc.
    #   engine: 'Postgres' # figure out a better term here
    #   optional: true,
    #   validate_with: ->(val) { val.kind_of?(Time) }, # or /\A\S{4,}\Z/
    #   validations: [],
    #   error_on_validate: false
    # }
    def self.valid_options
      %w(target search_type search_method optional validate_with validations
         error_on_validation_failure)
    end

    def self.valid_option?(key)
      unless valid_options.include?(key)
        raise InvalidOption
      end
      true
    end

    attr_accessor :options
    def initialize(options = {})
      options = HashWithIndifferentAccess.new.merge(options)
      self.options = options.reject {|k,v| !self.class.valid_option?(k) }
    end

    def valid? # is the filter ready to accept scope + params?
      # do we know what kind of search?
      # does it have a name?
      # etc ...
      true
    end

    # The field(s) to search
    def target
      options[:target]
    end

    # is the scope valid? AR scope vs. array, etc
    def valid_scope?(scope)
      true
    end

    # Are the given params valid? If an attribute is required, is it present?
    def valid_params?(params)
      true
    end

    def search_method
      options[:search_method]
    end

    def apply_to(scope, params = {})
      search_method.call(scope, params)
    end
  end
end
