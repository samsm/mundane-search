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
    #   error_on_validate: false,
    #   issolate_with: :name_of_issolation_filter
    #   argument_issolation: :which_param,
    #                        [:params_a, :params_b]
    #                        ->(params) { params.inspect }
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

    attr_accessor :options# , :errors
    # Probably need errors to provide feedback on why something didn't search.

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
      options[:target] || options[:name]
    end

    # is the scope valid? AR scope vs. array, etc
    def valid_scope?(scope)
      true
    end

    # Are the given params valid? If an attribute is required, is it present?
    # appropiate arity for search method
    def valid_params?(params)
      execute_validation() if options[:validate_with]
    end

    def issolate_arguments(params)
      ai = options[:issolate_with] || options[:argument_issolation]
      case ai
      when Symbol
        params[ai]
      when Array
        params.values_at(ai)
      when Proc
        ai.call(params)
      else
        params
      end
    end

    def execute_validation(validation, value)
      if validation ===  Regexp
        value =~ validation
      elsif validation.respond_to?(:call)
        validation.call(value)
      else
        puts 'What kind of validation was that?'
        # ??
      end
    end

    def search_method
      options[:search_method]
    end

    def apply_to(scope, params = {})
      search_method.call(scope, targets, params)
    end

    # def temp_example_where(target, arguments)
    #   scope.where(["? = ?", target, argument])
    # end
    # def temp_where_one_of(scope, targets, terms, options = {})
    #   # arguments.inject(scope) {|scp, arg| scp.where ...}
    #   scope.where({ target: arguments })
    # end
  end
end

# it "should filter with proc" do
#   proc = ->(scope, params) { scope.select {|s| s > 2 } }
#   filter = Filter.new(search_method: proc)
#   filter.apply_to([1,2,3,4,5]).must_equal([3,4,5])
# end

