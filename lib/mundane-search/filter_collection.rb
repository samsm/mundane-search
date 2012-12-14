module MundaneSearch
  class FilterCollection
    attr_accessor :filters

    def initialize(filters)
      self.filters = filters
    end

    def add(filter)
    end

    def execute(collection, params = {}, select = nil, skip_when = nil)
      select    ||= ->(filter) { true }
      skip_when ||= ->(c,p)    { false }
      params
      filters.select(&select).inject(collection) do |coll, filter|
        unless skip_when.call(coll, params)
          filter.apply_to(coll, params)
        end
      end
    end
  end
end