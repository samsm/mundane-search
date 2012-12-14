module MundaneSearch
  class Collection
    attr_accessor :filters

    def initialize(filters)
      self.filters = filters
    end

    def add(filter)
    end

    def execute(collection, params = {}, select = nil, skip_when = nil)
      select    ||= -> { true }
      skip_when ||= ->(c,p) { false }
      filters.select(select).inject(collection) do |coll, filter|
        unless skip_when.call(collection, params)
          filter.apply_to(coll, params)
        end
      end
    end
  end
end