module MundaneSearch
  class Filter
    # {
    #   name: 'Awesomefilter',
    #   target: 'created_at',
    #   search_type: 'time',
    #   optional: true,
    #   validate_with: ->(val) { val.kind_of?(Time) }, # or /\A\S{4,}\Z/
    #   validations: [],
    #   error_on_validate: false
    # }
    # %w(target search_type optional validate_with validations error_on_validation_failure)
    attr_accessor :options
    def initialize(options = {})
      self.options = HashWithIndifferentAccess.new.merge(options)
    end

    def valid? # is the filter ready to accept scope + params?
      # do we know what kind of search?
      # does it have a name?
      # etc ...
    end

    def valid_scope?(scope)   ; end
    def valid_params?(params) ; end

    def apply_to(scope, params = {})
      scope
    end
  end
end
