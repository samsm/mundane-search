require_relative 'minitest_helper'
requirements_for_form_for_tests!

describe "integration search_form_for" do
  let(:built)  { MundaneSearch::Builder.new }
  let(:result) { built.result_for(open_struct_books, params)}
  let(:search_formed_class) do
    Class.new(formed_class) do
      include MundaneSearch::ViewHelpers
    end
  end
  let(:formed) { search_formed_class.new }

  it "should generate form with method=get" do
    form = formed.search_form_for(result) { }
    form.must_match %r{<form[^>]+method="get"}
  end
end
