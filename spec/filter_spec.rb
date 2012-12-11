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

  describe "#search_method" do
    it "should use option[:search_method]" do
      proc = ->(a,b,c) { 'nice' }
      result = Filter.new(search_method: proc).search_method
      assert_equal result, proc
    end
  end

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

    it "should extract through proc" do
      Filter.new(extract_conditions: ->(params) { params.length }).
        extract_conditions(@params).must_equal(2)
    end
  end

end