require_relative 'minitest_helper'
requirements_for_form_for_tests!

describe "integration search_form_for" do
  let(:result_class) { Class.new(MundaneSearch::Result) }
  let(:result) { result_class.new(open_struct_books, params) }
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
