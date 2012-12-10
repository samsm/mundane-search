require 'active_support/hash_with_indifferent_access'
module MundaneSearch
  class InvalidOption < StandardError ; end
  class Filter
    def self.valid_option?(key)
      valid_options = [:extract_conditions]
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

  end
end