module MundaneSearch
  class InitialResult < Result
    def initialize(collection,params)
      @collection, @params = collection, params
    end
  end
end