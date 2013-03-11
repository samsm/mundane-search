require_relative '../minitest_helper'

describe MundaneSearch::Filters::ExactMatch do
  ExactMatch = MundaneSearch::Filters::ExactMatch

  let(:collection) { %w(foo bar baz)    }
  let(:params)     { { 'foo' => 'bar' } }

  it "should only take effect if matching param is avilable" do
    options = { param_key: 'unmatched' }
    em = ExactMatch.new(collection, params, options)
    coll, parms = em.call
    coll.must_equal(collection)
  end

  it "should match equivalent element" do
    options = { param_key: 'foo' }
    em = ExactMatch.new(collection, params, options)
    coll, parms = em.call
    coll.must_equal(['bar'])
  end

end
