module MundaneSearch
  class FilterCanister
    attr_reader :filter, :options
    def initialize(filter, *args)
      @filter, @options = filter, args
    end

    def build(collection, params)
      filter.new(collection, params, *options)
    end
  end
end