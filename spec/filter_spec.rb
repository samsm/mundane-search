require_relative 'minitest_helper'

describe MundaneSearch::Filter do
  Filter = MundaneSearch::Filter
  it "should be a class" do
    Filter.must_be_kind_of Class
  end

  it "should reject bad options" do
    proc {
      Filter.new(invalid_option: 1)
    }.must_raise(MundaneSearch::InvalidOption)
  end

  # it "should filter with proc" do
  #   proc = ->(scope, params) { scope.select {|s| s > 2 } }
  #   filter = Filter.new(search_method: proc)
  #   filter.apply_to([1,2,3,4,5]).must_equal([3,4,5])
  # end

  describe "#extract_conditions" do
    before do
      @params = { title: 'Ruby', author: 'Matz' }
    end
    it "should extract using param key" do
      Filter.new(extract_conditions: :title).extract_conditions(@params).
        must_equal('Ruby')
    end

    it "should extract multiple values" do
      Filter.new(extract_conditions: [:title, :author]).
        extract_conditions(@params).sort.
        must_equal(['Matz', 'Ruby'])
    end
  end

end