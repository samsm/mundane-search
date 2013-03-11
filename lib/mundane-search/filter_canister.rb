module MundaneSearch
  class FilterCanister
    attr_reader :filter, :options
    def initialize(filter, *args)
      @filter, @options = filter, args
    end

    def call(collection, params)
      filter.new(collection, params, *options).call
    end
  end
end