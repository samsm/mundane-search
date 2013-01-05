require 'active_support/hash_with_indifferent_access'

module MundaneSearch
  class InvalidOption < StandardError ; end
  class Filter
    def self.valid_option?(key)
      valid_options = [:extract_conditions, :search_method]
      raise InvalidOption unless valid_options.include?(key)
      true
    end

    attr_accessor :options
    def initialize(options = {})
      self.options = options.reject {|k,v| !self.class.valid_option?(k) }
    end

    def extract_conditions(params = {})
      ai = options[:extract_conditions]
      case ai
      when Symbol
        params[ai]
      when Array
        params.values_at(*ai)
      when Proc
        ai.call(params)
      else
        params
      end
    end

    def search_method
      options[:search_method]
    end

    def apply_to(scope, params)
      search_method.call(scope, extract_conditions(params))
    end
  end
end