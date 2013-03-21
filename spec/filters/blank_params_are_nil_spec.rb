require_relative '../minitest_helper'

describe MundaneSearch::Filters::BlankParamsAreNil do
  it "should remove empty values from params" do
    params = { empty_string: '', empty_array: [], empty_hash: {} }
    bpan = MundaneSearch::Filters::BlankParamsAreNil.new([], params)
    bpan.filtered_params[:empty_string].must_be_nil
    bpan.filtered_params[:empty_array].must_be_nil
    bpan.filtered_params[:empty_hash].must_be_nil
  end
end