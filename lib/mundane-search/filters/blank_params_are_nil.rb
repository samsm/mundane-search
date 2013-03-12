module MundaneSearch::Filters
  class BlankParamsAreNil < Base
    def filtered_params
      params.inject({}) do |h,e|
        val = e.last
        hash[e.first] = (val.nil? || val.empty?) ? nil : val
        hash
      end
    end
  end
end
