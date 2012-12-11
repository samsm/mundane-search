require_relative 'minitest_helper'

describe MundaneSearch::Filter do
  Filter = MundaneSearch::Filter

  describe "#apply_to" do
    it "should run search_method" do
      sm = ->(scope,arg) { 'result!' }
      filter = Filter.new(search_method: sm)
      filter.apply_to(:scope, {}).must_equal('result!')
    end

    it "should search objects" do
      colors = %w(Red Orange Yellow Green Blue Indigo Violet)
      sm = ->(scope,arg) { scope.select {|c| Regexp.new(arg).match(c) } }
      filter = Filter.new(search_method: sm, extract_conditions: :regex)
      filter.apply_to(colors, {regex: 'l'}).sort.
        must_equal(%w(Blue Violet Yellow))
    end
  end

end